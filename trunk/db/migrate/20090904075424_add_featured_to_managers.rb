class AddFeaturedToManagers < ActiveRecord::Migration
  def self.up
    add_column :managers, :featured, :boolean, :default => false
  end

  def self.down
    remove_column :managers, :featured
  end
end
