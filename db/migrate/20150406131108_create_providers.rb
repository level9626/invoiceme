class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :logo
      t.string :name
      t.string :logo
      t.string :name
      t.string :intermediary_bank
      t.string :account_with_institution
      t.string :beneficiary_account
      t.string :beneficiary

      t.timestamps
    end
  end
end
