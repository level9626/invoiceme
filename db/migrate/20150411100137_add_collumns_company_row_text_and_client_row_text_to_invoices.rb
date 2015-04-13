class AddCollumnsCompanyRowTextAndClientRowTextToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :company_row_text, :text, null: false
    add_column :invoices, :client_row_text, :text,  null: false
  end
end