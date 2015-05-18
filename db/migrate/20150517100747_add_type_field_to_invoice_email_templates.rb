class AddTypeFieldToInvoiceEmailTemplates < ActiveRecord::Migration
  def change
    remove_column :invoice_email_templates, :owner_id
    add_reference :invoice_email_templates, :email_templatable, \
                  polymorphic: true, \
                  index: { name: :invoice_email_templates_email_templatable }
  end
end
