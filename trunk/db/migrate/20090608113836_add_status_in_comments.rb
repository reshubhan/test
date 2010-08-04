class AddStatusInComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :status, :string, :default => "approved" 
  end

  def self.down
    remove_column("comments", "status")
  end
end
