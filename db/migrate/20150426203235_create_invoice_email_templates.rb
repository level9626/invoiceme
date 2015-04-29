class CreateInvoiceEmailTemplates < ActiveRecord::Migration
  def change
    create_table :invoice_email_templates do |t|
      t.string :name, limit: 100
      t.text :template_body
      t.string :template_subject
      t.integer :owner_id, index: true

      t.timestamps
    end
  end
end
