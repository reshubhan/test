class RemoveFundsSecondaries < ActiveRecord::Migration
  def self.up
    add_column :secondaries, :fund_id, :integer
    drop_table :funds_secondaries
  end

  def self.down
    create_table "funds_secondaries" do |t|
      t.column :fund_id, :integer, :null => false
      t.column :seconday_id, :integer, :null => false
    end
    remove_column(:secondaries, :fund_id)
  end
end
