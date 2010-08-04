class RenameManagerattribute < ActiveRecord::Migration
  def self.up
    remove_column :manager_attributes, :attribute_id
    add_column :manager_attributes, :asset_attribute_id, :integer, :null => false
    rename_table("manager_attributes", "asset_attribute_managers")
  end

  def self.down
    rename_table("asset_attribute_managers", "manager_attributes")
    add_column :manager_attributes, :attribute_id, :integer, :null => false
    remove_column :manager_attributes, :asset_attribute_id
  end
end
