class AddBankingOverheadToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :banking_overhead, :integer
  end
end
