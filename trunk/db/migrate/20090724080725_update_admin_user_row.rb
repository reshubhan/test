class UpdateAdminUserRow < ActiveRecord::Migration
  def self.up
    User.find_by_login("admin").update_attribute("paid",true)
  end

  def self.down
    User.find_by_login("admin").update_attribute("paid",false)
  end
end
