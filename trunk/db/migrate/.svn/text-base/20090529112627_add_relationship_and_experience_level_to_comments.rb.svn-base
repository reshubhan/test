class AddRelationshipAndExperienceLevelToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :relationchip, :string
    add_column :comments, :experience_level, :string
  end

  def self.down
    remove_column :comments, :relationchip
    remove_column :comments, :experience_level
  end
end
