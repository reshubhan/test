class Role < ActiveRecord::Base
  has_many :organization_types
  has_and_belongs_to_many :notifications
  has_and_belongs_to_many :users
  has_many :plans

  def Role.user_roles
    roles = Role.all
    roles.delete(Role.find_by_title("Admin"))
    roles
  end

  def active_plans
    self.plans.find(:all,:conditions=>"status=1",:order=>"id")
  end
end
