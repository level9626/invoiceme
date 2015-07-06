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
