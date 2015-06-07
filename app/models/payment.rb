# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  invoice_id :integer          not null
#  amount     :float            not null
#  created_at :datetime
#  updated_at :datetime
#  currency   :string(255)
#

class Payment < ActiveRecord::Base
  include Modules::WithCurrency
  ## Relations
  belongs_to :invoice
  has_one :user, through: :invoice
  has_one :client, through: :invoice
  has_one :company, through: :invoice

  ## Validations
  validates :invoice_id, :amount, :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.1 }

  ## Scopes
  scope :sum_amount, -> { where.not(id: nil).sum(:amount) }

  ## Callbacks
  after_save :_update_invoice!

  def amount_with_currency
    _with_currency(amount)
  end

  private

  ## Callbacks handlers

  def _update_invoice!
    invoice.payment_received
  end
end
