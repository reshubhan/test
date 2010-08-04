class AddManagerName < ActiveRecord::Migration
  def self.up
    Profile.find_by_sql("select p.id from users u inner join plans pl on u.plan_id=pl.id inner join roles r on pl.role_id=r.id inner join profiles p on p.user_id=u.id where r.id=2 and u.status='approved' and p.organization_name is null").each do |profile|
      if User.find(Profile.find(profile.id).user_id).manager_id
        Profile.find(profile.id).update_attribute(:organization_name,Manager.find(User.find(Profile.find(profile.id).user_id).manager_id).name.to_s)
      end
    end
  end

  def self.down
    execute "update profiles set organization_name=null where user_id in (select u.id from users u inner join plans pl on u.plan_id=pl.id inner join roles r on pl.role_id=r.id inner join profiles p on p.user_id=u.id where r.id=2 and u.status='approved' and p.organization_name is null)"
  end
end
