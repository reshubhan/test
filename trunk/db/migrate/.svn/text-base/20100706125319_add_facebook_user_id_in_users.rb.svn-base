class AddFacebookUserIdInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_user_id, :integer
  end

  def self.down
    remove_column(:users, :facebook_user_id)
  end
end
