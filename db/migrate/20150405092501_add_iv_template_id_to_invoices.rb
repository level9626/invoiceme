class AddIvTemplateIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :iv_template_id, :integer, null: false
  end
end
