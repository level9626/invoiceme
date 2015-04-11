class AddCollumnIntoiceItemsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :invoice_items, :hstore, null: false, default: {}
  end
end
