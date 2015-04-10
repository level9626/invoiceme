class CreateUsersClientsJoinTable < ActiveRecord::Migration
  def change
    create_table :clients_users, id: false do |t|
      t.integer :user_id
      t.integer :client_id
    end

    add_index :clients_users, [:user_id, :client_id], unique: true
  end
end
