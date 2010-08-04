class RenameColumnRelationshipInComments < ActiveRecord::Migration
  def self.up
    rename_column(:comments, :relationchip, :relationship)
  end

  def self.down
    rename_column(:comments, :relationship, :relationchip)
  end
end
