class RemoveColumnPremiumFromSecondary < ActiveRecord::Migration
  def self.up
    remove_column("secondaries", "premium")
  end

  def self.down
    add_column :secondaries, :premium, :integer
  end
end
