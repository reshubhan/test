class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table "roles_users", :id => false, :force => true do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :roles_users
  end
end
