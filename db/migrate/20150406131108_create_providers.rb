class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
<<<<<<< HEAD
<<<<<<< HEAD
      t.string :logo
      t.string :name
=======
      t.stging :logo
      t.stging :name
>>>>>>> 278941a... Provider
=======
      t.string :logo
      t.string :name
>>>>>>> cfab802... M
      t.string :intermediary_bank
      t.string :account_with_institution
      t.string :beneficiary_account
      t.string :beneficiary

      t.timestamps
    end
  end
end
