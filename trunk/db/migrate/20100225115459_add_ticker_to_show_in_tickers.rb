class AddTickerToShowInTickers < ActiveRecord::Migration
  def self.up
    add_column :tickers,:ticker_to_show,:boolean
  end

  def self.down
    remove_column(:tickers, :ticker_to_show)
  end
end
