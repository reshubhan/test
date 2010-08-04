class AddUpdateInfoInModels < ActiveRecord::Migration
  def self.up
    add_column :users, :updated_by, :integer
    add_column :managers, :updated_by, :integer
    add_column :managers, :created_by, :integer
    add_column :funds, :updated_by, :integer
    add_column :funds, :created_by, :integer
    add_column :profiles, :updated_by, :integer
    add_column :secondaries, :updated_by, :integer
    add_column :secondaries, :created_by, :integer
    add_column :assets, :updated_by, :integer
    add_column :assets, :created_by, :integer
    add_column :attributes, :updated_by, :integer
    add_column :attributes, :created_by, :integer
    add_column :geographies, :created_by, :integer
    add_column :geographies, :updated_by, :integer
    add_column :geographies, :created_at, :integer
    add_column :geographies, :updated_at, :integer
  end

  def self.down
    remove_column :users, :updated_by
    remove_column :managers, :updated_by
    remove_column :managers, :created_by
    remove_column :funds, :updated_by
    remove_column :funds, :created_by
    remove_column :profiles, :updated_by
    remove_column :secondaries, :updated_by
    remove_column :secondaries, :created_by
    remove_column :assets, :updated_by
    remove_column :assets, :created_by
    remove_column :attributes, :updated_by
    remove_column :attributes, :created_by
    remove_column :geographies, :created_by
    remove_column :geographies, :updated_by
    remove_column :geographies, :created_at
    remove_column :geographies, :updated_at
  end
end
