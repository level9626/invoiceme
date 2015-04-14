class AddInvoiceFields < ActiveRecord::Migration
  def up
    add_column :invoices,      :subtotal, :float, null: false
    add_column :invoices,      :vat_rate, :float
    add_column :invoices,      :vat,      :float
    add_column :invoices,      :discount, :float
    add_column :invoice_items, :amount,   :float, null: false
  end

  def down
    remove_column :invoices,      :subtotal
    remove_column :invoices,      :vat_rate
    remove_column :invoices,      :vat
    remove_column :invoices,      :discount
    remove_column :invoice_items, :amount
  end
end
