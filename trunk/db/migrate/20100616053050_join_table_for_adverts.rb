class JoinTableForAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts_assets do |t|
      t.integer :advert_id
      t.integer :asset_id
    end
    remove_column(:adverts_assets, :id)
    create_table :adverts_geographies do |t|
      t.integer :advert_id
      t.integer :geography_id
    end
    remove_column(:adverts_geographies, :id)
  end

  def self.down
    drop_table(:adverts_assets)
    drop_table(:adverts_geographies)
  end
end
