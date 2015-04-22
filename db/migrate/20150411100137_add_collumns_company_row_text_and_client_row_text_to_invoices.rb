# In addition to client/company references from the model, we will also store
# client/company as a row html file, in order to have it editable.
class AddCollumnsCompanyRowTextAndClientRowTextToInvoices < \
      ActiveRecord::Migration
  def change
    add_column :invoices, :company_row_text, :text, null: false
    add_column :invoices, :client_row_text, :text,  null: false
  end
end
