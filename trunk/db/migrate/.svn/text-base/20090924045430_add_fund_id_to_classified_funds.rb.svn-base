class AddFundIdToClassifiedFunds < ActiveRecord::Migration
  def self.up
    add_column :classified_funds, :fund_id, :integer
    drop_table :classified_funds_funds
  end

  def self.down
    remove_column :classified_funds, :fund_id
    create_table "classified_funds_funds", :id => false do |t|
      t.column :fund_id, :integer, :null => false
      t.column :classified_fund_id, :integer, :null => false
    end
  end
end
