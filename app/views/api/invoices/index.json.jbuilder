json.invoices do 
  json.array!(@invoices) do |invoice|
    json.extract! invoice, :id, :invoice_number, :invoice_date, :currency, \
                           :created_at, :updated_at, :subtotal, :state

    json.client invoice.client
    json.company invoice.company
    json.payments invoice.payments
    json.total invoice.total
    json.total invoice.subtotal
  end
end

json.partial! 'api/shared/pagination', collection: @invoices
