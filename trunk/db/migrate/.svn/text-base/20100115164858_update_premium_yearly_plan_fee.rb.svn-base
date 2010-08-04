class UpdatePremiumYearlyPlanFee < ActiveRecord::Migration
  def self.up
    execute "update plans set fee=11988 where fee=11599;"
  end

  def self.down
    execute "update plans set fee=11599 where fee=11988;"
  end
end
