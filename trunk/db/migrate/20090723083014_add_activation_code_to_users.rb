class AddActivationCodeToUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :status
    add_column :users, :status, :string, :default => 'unapproved'
    add_column :users, :activation_code, :string
    users = User.find(:all)
    users.each do |user|
      user.update_attribute("status", "approved")
    end
  end

  def self.down
    remove_column :users, :status
    add_column :users, :status, :string, :default => 'approved'
    remove_column :users, :activation_code
  end
end
