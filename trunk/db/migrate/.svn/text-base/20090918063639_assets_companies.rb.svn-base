class AssetsCompanies < ActiveRecord::Migration
  def self.up
    create_table "assets_companies", :id => false do |t|
      t.column :asset_id, :integer, :null => false
      t.column :company_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :assets_companies
  end
end
