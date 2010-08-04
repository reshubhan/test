class PlanSwaped < ActiveRecord::Migration
  def self.up
    execute "update plans set role_id=2 where id=5;"
    execute "update plans set role_id=2 where id=6;"
    execute "update plans set role_id=2 where id=7;"
    execute "update plans set role_id=2 where id=8;"
    execute "update plans set role_id=3 where id=9;"
    execute "update plans set role_id=3 where id=10;"
    execute "update plans set role_id=3 where id=11;"
    execute "update plans set role_id=3 where id=12;"
  end

  def self.down
  end
end
