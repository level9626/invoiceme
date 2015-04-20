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
#  status           :string(255)      default("open"), not null
#

class Invoice < ActiveRecord::Base
  # TODO: Make enums here => enum role: [:user, :vip, :admin]
  CURRENCY = ['EUR','USD','UAH','RUB']
  STATUS   = ['open', 'closed', 'overdue']

  ## Relations
  belongs_to :company
  belongs_to :client
  belongs_to :user
  has_many   :invoice_items
  has_many   :payments

  ## Nested forms
  accepts_nested_attributes_for :invoice_items

  ## Validations
  # Iterates through constants, and dynamically creates validations
  [:CURRENCY, :STATUS].each do |param|
    inclusion = eval(param.to_s)
    validates param.downcase, inclusion: {
                           in: inclusion,
                           message: "is not included in the list #{inclusion.join(',')}"
                       }
  end

  validates :invoice_number, :invoice_date, presence: true
  validates :user_id, :company_id, :client_id, presence: true
  validates :company_row_text, :client_row_text, length: {in: 1..300}
  validates :subtotal, presence: true, numericality: true
  validates :vat_rate, :vat, :discount, numericality: true, allow_blank: true

  ## Class methods
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |invoice|
        csv << invoice.attributes.values_at(*column_names)
      end
    end
  end

  ## Instance methods
  def amount
    invoice_items.map(&:sum).reduce(:+)
  end

  def close!
    update_attribute(status: 'closed')
  end

  def overdue!
    update_attribute(status: 'overdue')
  end

end
