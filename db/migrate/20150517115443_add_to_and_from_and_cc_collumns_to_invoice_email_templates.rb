class AddToAndFromAndCcCollumnsToInvoiceEmailTemplates < ActiveRecord::Migration
  def change
    add_column :invoice_email_templates, :to, :string, array: true, default: '{}'
    add_column :invoice_email_templates, :cc, :string, array: true, default: '{}'
    add_column :invoice_email_templates, :from, :string
    add_column :invoice_mails, :from, :string
  end
end
