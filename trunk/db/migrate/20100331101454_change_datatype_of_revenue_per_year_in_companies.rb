class ChangeDatatypeOfRevenuePerYearInCompanies < ActiveRecord::Migration
  def self.up
    change_column :companies, :revenue_per_year, :string
  end

  def self.down
    change_column :companies, :revenue_per_year, :float
  end
end
