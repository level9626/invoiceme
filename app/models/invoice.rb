# == Schema Information
#
# Table name: invoices
#
#  id               :integer          not null, primary key
#  invoice_number   :string(255)      not null
#  invoice_date     :datetime         not null
#  user_id          :integer          not null
#  currency         :string(255)      not null
#  comment          :text             default(""), not null
#  company_id       :integer          not null
#  client_id        :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  company_row_text :text             not null
#  client_row_text  :text             not null
#  subtotal         :float            not null
#  vat_rate         :float
#  vat              :float
#  discount         :float
#  state            :string(20)       default("new"), not null
#  net              :datetime
#

class Invoice < ActiveRecord::Base
  include InvoiceMachine
  include Modules::WithCurrency
  CURRENCY = %w(EUR USD UAH RUB)
  STATE = state_machines[:state].states.map(&:name).map(&:to_s)

  # Default query scope
  default_scope { where.not(state: 'closed') }
  scope :open, -> { where.not(state: [:closed, :bad_debt]) }

  ## Relations
  belongs_to :company
  belongs_to :client
  belongs_to :user
  has_many :invoice_items, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :invoice_mails
  has_many :invoice_email_templates

  ## Nested forms
  accepts_nested_attributes_for :invoice_items
  accepts_nested_attributes_for :invoice_mails

  ## Validations
  # Iterates through constants, and dynamically creates validations
  # TODO: need to be tested
  [:CURRENCY, :STATE].each do |param|
    # rubocop:disable all
    inclusion = eval param.to_s
    # rubocop:enable all
    message = "is not included in the list: #{inclusion.join(',')}"
    validates param.downcase, inclusion: { in: inclusion, message: message }
  end

  validates :invoice_number, :invoice_date, presence: true
  validates :user_id, :company_id, :client_id, presence: true
  validates :company_row_text, :client_row_text, length: { in: 1..300 }
  validates :subtotal, presence: true, numericality: true
  validates :vat_rate, :vat, :discount, numericality: true, allow_blank: true
  validates :invoice_number, \
            uniqueness: { scope: [:user_id, :client_id, :company_id], \
                          message: 'should be unique' }

  ## by default invoice query doesn't show closed invoices
  default_scope { where.not(state: 'closed') }

  ## Instance methods
  # TODO: need to be tested
  def amount
    invoice_items.map(&:sum).reduce(:+)
  end

  # Generates unique invoice number for not persisted object
  def invoice_number
    self[:invoice_number] || _gen_number
  end

  # Invoice due date
  def due_date
    created_at + net.to_i
  end

  # Verify whether new object
  def can_have_instance_actions?
    id
  end

  # invoice balance. Total payed.
  def balance
    _with_currency(_balance)
  end

  def unpayed
    subtotal - _balance
  end

  # invoice total. Total Invoiced
  def total
    _with_currency(subtotal)
  end

  # percent payed
  def percent_payed
    (_normed_balance).percent_of(subtotal)
  end

  # Change state after peyment received.
  def payment_received
    publish if state? :new
    return close if percent_payed >= 100
    partly_pay
  end

  # Returns collection of user and client mail templates
  def grouped_mail_templates
    client.mail_templates + user.mail_templates
  end

  ## Class methods

  # Statistics
  def self.count_by_currency(user)
    connection.execute(<<-EOQ)
      SELECT currency, count(*) AS invoices_count
      FROM invoices
      WHERE user_id=#{user.id}
      AND state <> 'closed'
      GROUP BY currency;
    EOQ
  end

  def self.overdue_count_by_currency(user)
    connection.execute(<<-EOQ)
      SELECT currency, count(*) AS invoices_count
      FROM invoices
      WHERE state='overdue'
      AND user_id=#{user.id}
      AND state <> 'closed'
      GROUP BY currency;
    EOQ
  end

  private

  ## Private instance methods

  def _balance
    payments.sum_amount
  end

  def _normed_balance
    return subtotal if _balance > subtotal
    _balance
  end

  def _gen_number(number = nil)
    number ||= user.invoices.count
    num = '#' + (number + 1).to_s

    return num unless user.invoices.where(invoice_number: num).exists?
    _gen_number(number + 1)
  end
end
