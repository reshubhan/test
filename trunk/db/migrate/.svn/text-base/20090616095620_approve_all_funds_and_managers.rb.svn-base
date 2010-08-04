class ApproveAllFundsAndManagers < ActiveRecord::Migration
  def self.up
    execute "update managers set status='approved'"
    execute "update funds set status='approved'"
  end

  def self.down
  end
end
