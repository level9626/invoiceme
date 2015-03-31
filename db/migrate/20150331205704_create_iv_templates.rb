class CreateIvTemplates < ActiveRecord::Migration
  def change
    create_table :iv_templates do |t|
      t.string :name

      t.timestamps
    end
  end
end
