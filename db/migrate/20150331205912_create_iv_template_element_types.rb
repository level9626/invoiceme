class CreateIvTemplateElementTypes < ActiveRecord::Migration
  def change
    create_table :iv_template_element_types do |t|
      t.string :name

      t.timestamps
    end

    add_index :iv_template_element_types, :name, unique: true
  end
end
