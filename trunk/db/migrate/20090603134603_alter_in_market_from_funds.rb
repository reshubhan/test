class AlterInMarketFromFunds < ActiveRecord::Migration
  def self.up
    remove_column :funds, :in_market
    add_column :funds, :in_market, :boolean, :default => true
  end

  def self.down
    remove_column :funds, :in_market
    add_column :funds, :in_market, :boolean
  end
end
