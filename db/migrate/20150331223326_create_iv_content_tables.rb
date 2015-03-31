class CreateIvContentTables < ActiveRecord::Migration
  def change
    create_table :iv_content_tables do |t|
      t.hstore :content

      t.timestamps
    end
  end
end
