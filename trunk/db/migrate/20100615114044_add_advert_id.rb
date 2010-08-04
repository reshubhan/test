class AddAdvertId < ActiveRecord::Migration
  def self.up
    add_column :assets, :advert_id, :integer
    add_column :geographies, :advert_id, :integer
  end

  def self.down
    remove_column(:assets, :advert_id)
    remove_column(:geographies, :advert_id)
  end
end
