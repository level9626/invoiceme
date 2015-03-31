class CreateIvContentTexts < ActiveRecord::Migration
  def change
    create_table :iv_content_texts do |t|
      t.text :content

      t.timestamps
    end
  end
end
