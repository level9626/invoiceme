json.payments do 
  json.array!(@payments) do |payment|
    json.extract! payment, :id, :invoice_id, :amount, :created_at
    json.invoice payment.invoice
    json.client payment.client
    json.company payment.company
  end
end

json.partial! 'api/shared/pagination', collection: @payments
