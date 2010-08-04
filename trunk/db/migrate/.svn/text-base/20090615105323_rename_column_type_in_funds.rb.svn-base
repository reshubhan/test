class RenameColumnTypeInFunds < ActiveRecord::Migration
  def self.up
    rename_column(:funds, :type, :fund_type)
  end

  def self.down
    rename_column(:funds, :fund_type, :type)
  end
end
