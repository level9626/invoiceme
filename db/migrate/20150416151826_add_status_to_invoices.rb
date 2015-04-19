class AddStatusToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :status, :string, null: false, default: 'open'
  end
end
