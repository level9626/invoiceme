class AddPrimaryToInvoiceEmailTemplates < ActiveRecord::Migration
  def change
    add_column :invoice_email_templates, :primary, :boolean, null: false, default: false
  end
end
