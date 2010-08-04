class RemoveDescriptionFromManager < ActiveRecord::Migration
  def self.up
    remove_column :managers, :description
  end

  def self.down
    add_column :managers, :description, :text, :null => false
  end
end
