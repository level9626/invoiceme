# == Schema Information
#
# Table name: invoice_items
#
#  id             :integer          not null, primary key
#  description    :string(255)      default(""), not null
#  hours_or_tasks :float            not null
#  rate           :float            not null
#  invoice_id     :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :float            not null
#
class InvoiceItem < ActiveRecord::Base
  ## Relations
  belongs_to :invoice

  ## Validations
  validates :hours_or_tasks, :rate, :amount, presence: true
  validates :rate, :hours_or_tasks, :amount, numericality: true

  ## Scopes
  default_scope { order('created_at DESC') }
  scope :sum_amount, -> { where.not(id: nil).sum(:amount) }

  ## Callbacks
  after_save :_update_invoice

  private

  def _update_invoice
    return if invoice.subtotal == invoice.invoice_items.sum_amount
    invoice.update_attribute(:subtotal, invoice.invoice_items.sum_amount)
  end
end
