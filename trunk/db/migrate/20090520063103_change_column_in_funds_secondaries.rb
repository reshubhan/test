class ChangeColumnInFundsSecondaries < ActiveRecord::Migration
  def self.up
    rename_column :funds_secondaries, :seconday_id, :secondary_id
  end

  def self.down
    rename_column :funds_secondaries, :secondary_id, :seconday_id
  end
end
