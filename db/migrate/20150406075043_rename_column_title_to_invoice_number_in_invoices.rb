class RenameColumnTitleToInvoiceNumberInInvoices < ActiveRecord::Migration
  def change
    rename_column :invoices, :title, :invoice_number
  end
end
