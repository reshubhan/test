class AddAdminUser < ActiveRecord::Migration
  def self.up
    user = User.find_by_login('admin')
    if user.blank?
      execute "insert into users (login, crypted_password, salt, plan_id, email_alias) values ('admin', 'f0e87a982450758c4eb03053093f3d235cdd000a', '52d07ef832257720b5037ade486f452621b6896f',-1, 'admin@trustedinsightinc.com')"
      user = User.find_by_login('admin')
      execute "insert into profiles (firstname, lastname, email, user_id) values ('admin', 'admin', 'admin@trutsedinsight.com', " + user.id.to_s + " )"
      execute "insert into roles_users (role_id, user_id) values (4," + user.id.to_s + " )"
    end
  end

  def self.down
    user = User.find_by_login('admin')
    execute "delete from users where login='admin'"
    if not user.blank?
      execute "delete from profils where user_id=" + user.id.to_s
      execute "delete from roles_users where role_id = 4 and user_id = " + user.id.to_s
    end
  end
end
