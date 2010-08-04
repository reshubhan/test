class AddColumnImageInAssets < ActiveRecord::Migration
  def self.up
    add_column :assets, :image, :string
    add_column :geographies, :image, :string
  end

  def self.down
    remove_column(:assets, :image)
    remove_column(:geographies, :image)
  end
end
