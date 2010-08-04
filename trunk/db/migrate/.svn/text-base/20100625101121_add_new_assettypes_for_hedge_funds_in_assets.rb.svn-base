class AddNewAssettypesForHedgeFundsInAssets < ActiveRecord::Migration
  def self.up
    add_column :assets , :active_asset , :boolean , :default =>false
  end

  def self.down
    remove_column(:assets,:active_asset)
  end
end
