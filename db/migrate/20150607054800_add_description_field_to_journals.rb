class AddDescriptionFieldToJournals < ActiveRecord::Migration
  def change
    add_column :journals, :description, :string, null: false, default: ''
  end
end
