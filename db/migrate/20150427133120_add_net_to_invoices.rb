class AddNetToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :net, :datetime
  end
end
