class AddShowUserNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users ,:show_user_name,:boolean,:default => 0
  end

  def self.down
    remove_column(:users, :show_user_name)
  end
end
