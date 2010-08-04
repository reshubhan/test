class AddInMarketToFunds < ActiveRecord::Migration
  def self.up
    add_column :funds, :in_market, :boolean
  end

  def self.down
    remove_column :funds, :in_market
  end
end
