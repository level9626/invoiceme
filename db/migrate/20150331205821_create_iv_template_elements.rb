class CreateIvTemplateElements < ActiveRecord::Migration
  def change
    create_table :iv_template_elements do |t|
      t.integer :iv_template_id
      t.hstore :position
      t.integer :iv_template_element_type_id

      t.timestamps
    end

    add_index :iv_template_elements, :iv_template_id
  end
end
