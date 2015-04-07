json.array!(@companies) do |company|
  json.extract! company, :id, :logo, :name, :address, :user_id
  json.url company_url(company, format: :json)
end
