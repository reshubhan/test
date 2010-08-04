class AddNewColumnsToManagers < ActiveRecord::Migration
  def self.up
    add_column :managers, :new_name, :string
    add_column :managers, :new_url, :string
  end

  def self.down
    remove_column :managers, :new_name
    remove_column :managers, :new_url
  end
end
