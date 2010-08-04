class AddAssetToFunds < ActiveRecord::Migration
  def self.up
    add_column :funds, :asset_id, :integer
    add_column :funds, :asset_type_id, :integer
  end

  def self.down
    remove_column :funds, :asset_id
    remove_column :funds, :asset_type_id
  end
end
