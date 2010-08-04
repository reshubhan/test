class CreateFundsSecondaries < ActiveRecord::Migration
  def self.up
    create_table "funds_secondaries" do |t|
      t.column :fund_id, :integer, :null => false
      t.column :seconday_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :funds_secondaries
  end
end
