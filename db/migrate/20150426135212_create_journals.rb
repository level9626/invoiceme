class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :invoice_id, index: true
      t.string :event, limit: 20
      t.string :from, limit: 20
      t.string :to, limit: 20

      t.timestamps
    end
  end
end
