json.companies do 
  json.array!(@companies) do |company|
    json.extract! company, :id, :logo, :name, :name, :address, :user_id, \
                           :created_at, :updated_at, :default, :email
    json.logo company.logo_url

    json.states do
      json.draft company.invoices.draft.count
      json.unpaid company.invoices.unpaid.count
      json.partly company.invoices.partly.count
      json.paid company.invoices.paid.count
      json.overdue company.invoices.overdue.count
      json.bad_debt company.invoices.bad_debt.count
    end
  end
end
