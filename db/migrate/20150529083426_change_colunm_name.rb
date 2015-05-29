class ChangeColunmName < ActiveRecord::Migration
  def change
    rename_column :invoice_email_templates, :primary, :default
  end
end
