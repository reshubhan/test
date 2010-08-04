class AddColumnTypeToFunds < ActiveRecord::Migration
  def self.up
    add_column :funds, :type, :string
  end

  def self.down
    remove_column :funds, :type
  end
end
