# Adds default column to companies. Will be used to identify, whether
# company is default for the user
class AddDefaultColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :default, :boolean, null: false, default: false
  end
end