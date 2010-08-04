class RemoveLinkFromAssetGeography < ActiveRecord::Migration
  def self.up
    remove_column(:assets, :link)
    remove_column(:geographies, :link)
  end

  def self.down
    add_column :assets, :link, :integer
    add_column :geographies, :link, :integer
  end
end
