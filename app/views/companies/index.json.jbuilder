json.companies do 
  json.array!(@companies) do |company|
    json.extract! company, :id, :logo, :name, :name, :address, :user_id, \
                           :created_at, :updated_at, :default, :email
  end
end
