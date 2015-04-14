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
#

class Invoice < ActiveRecord::Base
  CURS = ['EUR','USD','UAH','RUB']
  belongs_to :company
  belongs_to :client
  belongs_to :user
  has_many   :invoice_items

  accepts_nested_attributes_for :invoice_items

  validates :currency, inclusion: {
                        in: CURS,
                        message: "is not included in the list #{CURS.join(',')}"
                       }
  validates :invoice_number, :invoice_date, presence: true
  validates :user_id, :company_id, :client_id, presence: true
  validates :company_row_text, :client_row_text, length: {in: 1..300}
  validates :subtotal, presence: true, numericality: true
  validates :vat_rate, :vat, :discount, numericality: true, allow_blank: true
end
