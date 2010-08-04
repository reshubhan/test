class CreateClassifiedFundsFunds < ActiveRecord::Migration
  def self.up
    create_table "classified_funds_funds", :id => false do |t|
      t.column :fund_id, :integer, :null => false
      t.column :classified_fund_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :classified_funds_funds
  end
end
