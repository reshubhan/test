class AlterColumnFlagInComments < ActiveRecord::Migration
  def self.up
    change_column_default :comments, :flag, 0
  end

  def self.down
  end
end
