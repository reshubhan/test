class CompaniesSectors < ActiveRecord::Migration
  def self.up
    create_table "companies_sectors", :id => false do |t|
      t.column :sector_id, :integer, :null => false
      t.column :company_id, :integer, :null => false
    end
  end

  def self.down
     drop_table :companies_sectors
  end
end
