class AddJournalablePolymorphicRelation < ActiveRecord::Migration
  def up
    # Migrating to new API
    Journal.destroy_all

    # New polymorphic fields
    add_column :journals, :journalable_id, :integer, null: false, index: true
    add_column :journals, :journalable_type, :string, null: false, index: true

    # redundant old fields
    remove_column :journals, :invoice_id
    remove_column :journals, :from
    remove_column :journals, :to
  end

  def down
    remove_column :journals, :journalable_id
    remove_column :journals, :journalable_type

    # redundant old fields
    add_column :journals, :invoice_id, :integer
    add_column :journals, :from, :string
    add_column :journals, :to, :string
  end
end
