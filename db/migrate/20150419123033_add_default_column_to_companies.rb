class AddDefaultColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :default, :boolean, null: false, default: false
  end
end
