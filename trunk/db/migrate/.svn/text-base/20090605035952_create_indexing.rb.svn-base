class CreateIndexing < ActiveRecord::Migration
  def self.up
    rename_column("assets_managers", "asset_is", "asset_id")
    add_index :profiles, :email
    add_index :profiles, :user_id
    add_index :assets, :id, :unique => true
    add_index :assets, :name
    add_index :attributes, :id, :unique => true
    add_index :attributes, :name
    add_index :managers, :id, :unique => true
    add_index :managers, :name
    add_index :funds, :id, :unique => true
    add_index :funds, :name
    add_index :geographies, :id, :unique => true
    add_index :geographies, :name
    add_index :secondaries, :id, :unique => true
    add_index :secondaries, :manager_id
    add_index :comments, :id, :unique => true
    add_index :comments, :manager_id
    add_index :comments, :user_id
    add_index :ratings, :id, :unique => true
    add_index :ratings, :manager_id
    add_index :ratings, :user_id
    add_index :asset_attributes, :id, :unique => true
    add_index :asset_attributes, :asset_id
    add_index :asset_attributes, :attribute_id
    add_index :assets_managers, :id, :unique => true
    add_index :assets_managers, :asset_id
    add_index :assets_managers, :manager_id
    add_index :asset_attribute_managers, :id, :unique => true
    add_index :asset_attribute_managers, :user_id
    add_index :asset_attribute_managers, :asset_attribute_id
    add_index :asset_attribute_managers, :manager_id
    

  end

  def self.down
    rename_column("assets_managers", "asset_id", "asset_is")
    remove_index :profiles, :email
    remove_index :profiles, :user_id
    remove_index :assets, :id
    remove_index :assets, :name
    remove_index :attributes, :id
    remove_index :attributes, :name
    remove_index :managers, :id
    remove_index :managers, :name
    remove_index :funds, :id
    remove_index :funds, :name
    remove_index :geographies, :id
    remove_index :geographies, :name
    remove_index :secondaries, :id
    remove_index :secondaries, :manager_id
    remove_index :comments, :id
    remove_index :comments, :manager_id
    remove_index :comments, :user_id
    remove_index :ratings, :id
    remove_index :ratings, :manager_id
    remove_index :ratings, :user_id
    remove_index :asset_attributes, :id
    remove_index :asset_attributes, :asset_id
    remove_index :asset_attributes, :attribute_id
    remove_index :assets_managers, :id
    remove_index :assets_managers, :asset_id
    remove_index :assets_managers, :manager_id
    remove_index :asset_attribute_managers, :id
    remove_index :asset_attribute_managers, :user_id
    remove_index :asset_attribute_managers, :asset_attribute_id
    remove_index :asset_attribute_managers, :manager_id
  end
end
