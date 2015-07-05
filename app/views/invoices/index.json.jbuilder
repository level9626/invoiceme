json.invoices do 
  json.array!(@invoices) do |invoice|
    json.extract! invoice, :id, :invoice_number, :invoice_date, :user_id, \
                           :currency, :comment, :company_id, :client_id, \
                           :created_at, :updated_at, :company_row_text, \
                           :client_row_text, :subtotal, :vat_rate, :vat, \
                           :discount, :state, :net
    json.url api_invoice_url(invoice, format: :json)
  end
end


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
