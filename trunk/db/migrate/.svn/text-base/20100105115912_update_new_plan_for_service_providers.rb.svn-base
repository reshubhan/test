class UpdateNewPlanForServiceProviders < ActiveRecord::Migration
  def self.up
    execute "update plans set fee=-1 where name='Plus' and role_id=3;"
    execute "update plans set fee=-1 where fee is null"
  end

  def self.down
    execute "update plans set fee=1995 where name='Plus' and duration='One Year' and role_id=3;"
    execute "update plans set fee=2995 where name='Plus' and duration='Two Years' and role_id=3;"
  end
end
