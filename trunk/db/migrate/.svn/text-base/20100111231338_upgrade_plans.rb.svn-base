class UpgradePlans < ActiveRecord::Migration
  def self.up
    execute "update plans set post_secondaries_to_buy=1;"
    execute "update plans set post_secondaries_to_sell=1;"
  end

  def self.down
    execute "update plans set post_secondaries_to_buy=0;"
    execute "update plans set post_secondaries_to_sell=0;"
  end
end
