class UpdatePlusAndPremiumPlans < ActiveRecord::Migration
   def self.up
    execute "update plans set fee=499 where fee=500;"
    execute "update plans set fee=999 where fee=1000;"
    execute "update plans set fee=5988 where fee=6000;"
    execute "update plans set fee=11988 where fee=12000;"
  end

  def self.down
    execute "update plans set fee=500 where fee=499;"
    execute "update plans set fee=1000 where fee=999;"
    execute "update plans set fee=6000 where fee=5988;"
    execute "update plans set fee=12000 where fee=11988;"
  end
end
