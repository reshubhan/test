class CreateFundsSectors < ActiveRecord::Migration
  def self.up
    create_table "funds_sectors", :id => false do |t|
      t.column :fund_id, :integer, :null => false
      t.column :sector_id, :integer, :null => false
    end
    remove_column :funds, :sector
  end

  def self.down
    drop_table :funds_sectors
    add_column :funds, :sector, :string
  end
end
