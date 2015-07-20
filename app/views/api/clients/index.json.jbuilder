json.clients do 
  json.array!(@clients) do |client|
    json.extract! client, :id, :name, :address
  end
end
