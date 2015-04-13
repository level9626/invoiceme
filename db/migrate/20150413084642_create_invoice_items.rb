class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.string  :description,    null: false, default: ''
      t.float   :hours_or_tasks, null: false
      t.float   :rate,           null: false
      t.integer :invoice_id,     null: false

      t.timestamps
    end

    add_index :invoice_items, :invoice_id
  end
end
