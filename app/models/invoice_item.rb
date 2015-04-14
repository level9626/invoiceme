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
#

class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  validates_presence_of :hours_or_tasks, :rate, :amount
  validates :rate, :hours_or_tasks, :amount, numericality: true
end
