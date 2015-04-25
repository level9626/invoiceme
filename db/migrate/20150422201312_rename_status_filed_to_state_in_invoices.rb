class RenameStatusFiledToStateInInvoices < ActiveRecord::Migration
  def up
    rename_column :invoices, :status, :state
    change_column :invoices, :state, :string, null: false,
                                              default: 'new',
                                              :limit => 20
    add_index :invoices, :state
  end

  def down
    rename_column :invoices, :state, status
    change_column :invoices, :status, :string, null: false, default: 'open'
    remove_index :invoices, :state
  end
end
