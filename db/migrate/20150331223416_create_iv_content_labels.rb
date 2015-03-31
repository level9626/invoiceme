class CreateIvContentLabels < ActiveRecord::Migration
  def change
    create_table :iv_content_labels do |t|
      t.string :content

      t.timestamps
    end
  end
end
