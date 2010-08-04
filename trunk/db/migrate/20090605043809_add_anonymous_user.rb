class AddAnonymousUser < ActiveRecord::Migration
  def self.up
    execute "insert into users (login, crypted_password, salt, plan_id) values ('Anonymous', '', '03ec9336a15b0a783ed132a6cf736391bc0044d',-1)"
  end

  def self.down
    execute "delete from users where login='Anonymous'"
  end
end
