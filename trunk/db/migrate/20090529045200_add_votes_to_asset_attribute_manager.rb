class AddVotesToAssetAttributeManager < ActiveRecord::Migration
  def self.up
    add_column :asset_attribute_managers, :votes, :integer
  end

  def self.down
    remove_column :asset_attribute_managers, :votes
  end
end
