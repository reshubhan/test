class AddFeaturedToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :featured, :boolean, :default => false
  end

  def self.down
    drop_table :companies, :featured
  end
end
