# == Schema Information
#
# Table name: payments
#
#  id               :integer          not null, primary key
#  invoice_id       :integer          not null
#  amount           :float            not null
#  created_at       :datetime
#  updated_at       :datetime
#  currency         :string(255)
#  banking_overhead :integer
#

class Payment < ActiveRecord::Base
  include Modules::WithCurrency
  ## Relations
  belongs_to :invoice
  has_one :user, through: :invoice
  has_one :client, through: :invoice
  has_one :company, through: :invoice
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :journals, as: :journalable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true
  accepts_nested_attributes_for :comments, allow_destroy: true

  ## Validations
  validates :invoice_id, :amount, :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.1,
                                     less_than: 1_000_000 }
  validates :banking_overhead, numericality: { greater_than_or_equal_to: 0 }

  ## Scopes
  scope :sum_amount, -> { where.not(id: nil).sum(:amount) }

  ## Callbacks
  before_create :_update_invoice!
  before_update :_log_edition!
  before_destroy :_log_deletion!

  def amount_with_currency
    _with_currency(amount)
  end

  private

  ## Callbacks handlers

  def _update_invoice!
    invoice.payment_received
  end

  # rubocop:disable all
  def _log_edition!
    Journal.log(self.invoice, :edit_payment, amount_with_currency)
  end

  def _log_deletion!
    Journal.log(self.invoice, :remove_payment, amount_with_currency)
  end
  # rubocop:enable all
end
