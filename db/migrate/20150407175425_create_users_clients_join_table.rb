class CreateUsersClientsJoinTable < ActiveRecord::Migration
  def change
    create_table :users_clients, id: false do |t|
      t.integer :user_id
      t.integer :client_id
    end

    add_index :users_clients, [:user_id, :client_id], unique: true
  end
end
