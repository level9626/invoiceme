json.array!(@providers) do |provider|
  json.extract! provider, :id, :logo, :name, :intermediary_bank, :account_with_institution, :beneficiary_account, :beneficiary
  json.url provider_url(provider, format: :json)
end
