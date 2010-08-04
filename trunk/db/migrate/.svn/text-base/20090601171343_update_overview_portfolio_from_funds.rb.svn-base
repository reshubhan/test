class UpdateOverviewPortfolioFromFunds < ActiveRecord::Migration
  def self.up
    remove_column :funds, :overview
    remove_column :funds, :portfolio
    add_column :funds, :overview, :string
    add_column :funds, :portfolio, :string
#    change_column :funds, :overview, :string, :null=>false
#    change_column :funds, :portfolio, :string, :null=>false
  end

  def self.down
    remove_column :funds, :overview
    remove_column :funds, :portfolio
    add_column :funds, :overview, :string, :null => false
    add_column :funds, :portfolio, :string, :null => false
#    change_column :funds, :overview, :string, :null=>true
#    change_column :funds, :portfolio, :string, :null=>true
  end
end
