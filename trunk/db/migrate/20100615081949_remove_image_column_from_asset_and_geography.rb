class RemoveImageColumnFromAssetAndGeography < ActiveRecord::Migration
  def self.up
    remove_column(:assets, :image)
    remove_column(:geographies, :image)
  end

  def self.down
    add_column :assets, :image, :string
    add_column :geographies, :image, :string
  end
end
