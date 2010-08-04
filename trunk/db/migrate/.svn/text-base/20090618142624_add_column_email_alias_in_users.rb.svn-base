class AddColumnEmailAliasInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_alias, :string, :null => false
  end

  def self.down
    remove_column("users", "email_alias")
  end
end
