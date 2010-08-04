class RemoveAttributeTypeFromAttribute < ActiveRecord::Migration
  def self.up
    remove_column :attributes, :attribute_type
  end

  def self.down
    add_column :attributes, :attribute_type, :string, :null => false
  end
end
