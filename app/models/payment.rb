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
  ## Relations
  belongs_to :invoice
  has_one :user, through: :invoice
  has_one :client, through: :invoice
  has_one :company, through: :invoice

  ## Validations
  validates :invoice_id, :amount, :currency, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0.1 }

  ## Callbacks
  after_save :_update_invoice!

  private

  ## Callbacks handlers
  # TODO: need to be tested
  def _update_invoice!
    invoice.payment_received
  end
end
