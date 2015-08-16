class ChagneDefaultValueOfStateCollumnInInvoices < ActiveRecord::Migration
  def up
    change_column :invoices, :state, :string, null: false,
                                              default: 'draft',
                                              :limit => 20
  end

  def down
    change_column :invoices, :state, :string, null: false,
                                              default: 'new',
                                              :limit => 20
  end
end
