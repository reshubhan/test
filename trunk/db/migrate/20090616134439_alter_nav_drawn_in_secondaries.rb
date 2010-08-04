class AlterNavDrawnInSecondaries < ActiveRecord::Migration
  def self.up
    remove_column("secondaries", "net_asset_value")
    remove_column("secondaries", "drawn")
    add_column :secondaries, :net_asset_value, :string
    add_column :secondaries, :drawn, :string
  end

  def self.down
    remove_column("secondaries", "net_asset_value")
    remove_column("secondaries", "drawn")
    add_column :secondaries, :net_asset_value, :integer
    add_column :secondaries, :drawn, :integer
  end
end
