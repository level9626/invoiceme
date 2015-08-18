json.clients do 
  json.array!(@clients) do |client|
    json.extract! client, :id, :name, :address
    json.statistics client.invoices.profile_statistics
    # TODO refactoring to model instance method
    json.states do
      json.draft client.invoices.draft.count
      json.unpaid client.invoices.unpaid.count
      json.partly client.invoices.partly.count
      json.paid client.invoices.paid.count
      json.overdue client.invoices.overdue.count
      json.bad_debt client.invoices.bad_debt.count
    end
  end
end
