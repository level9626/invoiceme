json.extract! @company, :id, :name, :name, :address, :user_id, :created_at, \
                        :updated_at, :default, :email
json.logo @company.logo_url
