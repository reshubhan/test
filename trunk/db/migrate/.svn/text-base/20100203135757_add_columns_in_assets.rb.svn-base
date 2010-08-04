class AddColumnsInAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :default_size, :string
    add_column :assets, :default_type, :integer
    add_column :assets, :default_geo, :integer
    add_column :assets, :default_fund_size, :string
  end

  def self.down
    remove_column(:assets, :default_size)
    remove_column(:assets, :default_type)
    remove_column(:assets, :default_geo)
    remove_column(:assets, :default_fund_size)
  end
end
