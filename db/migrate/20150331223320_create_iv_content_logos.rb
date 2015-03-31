class CreateIvContentLogos < ActiveRecord::Migration
  def change
    create_table :iv_content_logos do |t|
      t.string :content

      t.timestamps
    end
  end
end
