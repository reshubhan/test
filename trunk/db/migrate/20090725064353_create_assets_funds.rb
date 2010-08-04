class CreateAssetsFunds < ActiveRecord::Migration
  def self.up
    create_table "assets_funds", :id => false do |t|
      t.column :asset_id, :integer, :null => false
      t.column :fund_id, :integer, :null => false
    end
    remove_column :funds, :asset_id
    remove_column :funds, :asset_type_id
  end

  def self.down
    add_column :funds, :asset_id, :integer
    add_column :funds, :asset_type_id, :integer
    drop_table :assets_funds
  end
end
