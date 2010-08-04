class ChangeInMarketInFunds < ActiveRecord::Migration
  def self.up
    change_column_default :funds, :in_market, false
  end

  def self.down
    change_column_default :funds, :in_market, true
  end
end
