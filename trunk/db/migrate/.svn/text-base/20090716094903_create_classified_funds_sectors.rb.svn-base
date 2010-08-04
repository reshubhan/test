class CreateClassifiedFundsSectors < ActiveRecord::Migration
  def self.up
    create_table "classified_funds_sectors", :id => false do |t|
      t.column :sector_id, :integer, :null => false
      t.column :classified_fund_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :classified_funds_sectors
  end
end
