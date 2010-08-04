class AddColumnTitleToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :title, :string, :null => false, :default => "New Commment"
  end

  def self.down
    remove_column :comments, :title
  end
end
