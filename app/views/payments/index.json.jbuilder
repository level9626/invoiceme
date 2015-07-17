json.payments do
  json.array!(@payments) do |payment|
    json.extract! payment, :id, :invoice_id, :amount

    json.url api_payment_url(payment, format: :json)
  end
end

