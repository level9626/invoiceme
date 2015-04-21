class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :invoice_id, null: false
      t.float :amount, null: false

      t.timestamps
    end

    add_index :payments, :invoice_id
  end
end
