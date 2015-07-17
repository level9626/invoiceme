json.clients do
  json.array!(@clients) do |client|
    json.extract! client, :id, :name, :address

    json.url api_client_url(client, format: :json)
  end
end