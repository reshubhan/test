class RenameUsertypeToRoleInQuestions < ActiveRecord::Migration
  def self.up
    rename_column(:questions, :user_type, :role)
  end

  def self.down
    rename_column(:questions, :role, :user_type)
  end
end
