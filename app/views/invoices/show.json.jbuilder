json.extract! @invoice, :id, :invoice_number, :invoice_date, :user_id, \
                         :currency, :comment, :company_id, :client_id, \
                         :created_at, :updated_at, :company_row_text, \
                         :client_row_text, :subtotal, :vat_rate, :vat, \
                         :discount, :state, :net
json.client @invoice.client
json.company @invoice.company
json.payments @invoice.payments
json.invoice_items @invoice.invoice_items
json.balance @invoice.balance
json.total @invoice.total
json.percent_payed @invoice.percent_payed