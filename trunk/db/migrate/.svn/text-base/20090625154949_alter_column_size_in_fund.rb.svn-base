class AlterColumnSizeInFund < ActiveRecord::Migration
  def self.up
    change_column :funds, :size, :float, :default => 0.0
  end

  def self.down
    change_column :funds, :size, :integer
  end
end
