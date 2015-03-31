class CreateIvElementContents < ActiveRecord::Migration
  def change
    create_table :iv_element_contents do |t|
      t.integer :invoice_id, index: true
      t.integer :iv_template_element_id
      t.string :iv_content_type
      t.integer :iv_content_id

      t.timestamps
    end
  end
end
