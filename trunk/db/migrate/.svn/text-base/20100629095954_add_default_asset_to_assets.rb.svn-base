class AddDefaultAssetToAssets < ActiveRecord::Migration
  def self.up
    add_column :assets ,:default_asset ,:boolean ,:default => false
  end

  def self.down
    remove_column :assets ,:default_asset
  end
end
