class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :logo
      t.string :name, null: false
      t.text :address, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :companies, :user_id
  end
end
