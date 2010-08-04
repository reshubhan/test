require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  attr_accessor :captcha
  attr_accessor :money_manager
  
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :questions
  has_one :facebook_user, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :funds
  has_many :payment_notifications
  has_many :classified_funds
  has_many :secondaries
  has_many :comments
  has_many :ratings
  has_many :manager_attributes
  has_many :managers
  has_many :payments
  has_many :orders
  belongs_to :plan
  has_many :logs
  has_many :comment_ratings
  belongs_to :approver, :class_name => 'User', :foreign_key => 'approver_id'
  belongs_to :manager, :class_name => 'Manager', :foreign_key => 'manager_id'
  has_many :saved_searches
  has_many :answers
  has_and_belongs_to_many :notifications
  
  validates_uniqueness_of   :email_alias, :allow_nil => true
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message, :if => :login_not_blank?
  validates_presence_of     :manager_id, :if => :is_money_manager?
 
  
  STATUS = ["approved", "unapproved", "deleted"]
  APPROVED = STATUS[0]
  UNAPPROVED = STATUS[1]
  DELETED = STATUS[2]
  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :emails, :replies, :plan_id, :views

  validate do |user|
    if user.login.blank?
      user.errors.add_to_base("User Name can't be blank")
    else
      user.errors.add_to_base("User Name is too short(Minimum is 3 characters)") if user.login.length<3 and user.login.length !=0
      user.errors.add_to_base("User Name is too long(Maximum is 3 characters)") if user.login.length>40
      user.errors.add_to_base("User Name has already been taken.") if User.find_by_login(user.login)
    end
  end

  def login_not_blank?
    !login.blank?
  end

  def all_classified_funds
    ClassifiedFund.find(:all, :conditions => "user_id=#{id} and status='approved'")
  end

  def no_of_postings
    ClassifiedFund.count(:all, :conditions => "user_id = #{self.id} and status = 'approved'")
  end

  def is_money_manager?
    self.money_manager == 1 ? true : false
  end

  # Authenticates a user by their User name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    if u.blank?
      p = Profile.find_by_email(login.downcase)
      u = p.user if p
    end
    u && u.authenticated?(password) && u.approved? && u.paid? ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end
  
  def change_password(old_password, new_password, new_password_confirmation)
    raise 'Old Password is required' if old_password == nil || old_password == ''
    raise 'Incorrect old password' unless self.crypted_password == User.password_digest(old_password,self.salt)
    raise 'New Password is required' if new_password == nil || new_password == ''
    raise 'New Password and Confirm New Password fields do not match' unless new_password != '' && new_password_confirmation != '' && new_password == new_password_confirmation
    raise 'Password size should be between 6-40 characters' unless new_password.length<=40 and new_password.length>=6 
    self.update_attribute(:crypted_password,User.password_digest(new_password,self.salt))
  end

  def fullname
    profile.firstname+ " " + profile.lastname
  end

  def has_role(user_role)
    assert=0
    roles.each { |role| if role.title == user_role then assert = 1 end }
    assert == 1 ? true : false
  end

  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

  def update_password(password)
    self.crypted_password = User.password_digest(password,self.salt)
    update
  end

  def approved?
    status==APPROVED ? true : false
  end

  def activate
    self.status = 'approved'
    self.approved_at = Date.today
    self.activation_code = nil
    save(false)
  end

  def self.active_users_count
    User.count_by_sql("select count(*) from users where status = 'approved' and activation_code is null and login!='Anonymous'");
  end

  def self.inactive_users_count
    User.count_by_sql("select count(*) from users where status != 'approved' or activation_code is not null and login!='Anonymous'");
  end

  def self.find_active_users(export)
    User.find(:all, :conditions => "users.status = 'approved' and activation_code is null and login != 'Anonymous' and login != 'admin'", :include => [:profile])
  end
  
  def recommend_plus
    if plan.rank==1 or plan.rank==3
      "checked='true'"
    else
      ""
    end
  end

  def recommend_premium
    if plan.rank==2 or plan.rank==4
      "checked='true'"
    else
      ""
    end
  end

  def recommend_year
    if plan.rank==3 or plan.rank==4
      "checked='true'"
    else
      ""
    end
  end

  def recommend_normal
    if plan.rank==1 or plan.rank==2
      "checked='true'"
    else
      ""
    end
  end

  def self.reminder_after_a_day
    logger.info"this is the testing od corn jobs..................................................."
    #@users=User.find(:all,:conditions=>"status='approved'")
    #for user in @users
    #  if user.plan.rank==1 && ((user.created_at).to_time).size == 24
    #    url = 'http://' + request.env["HTTP_HOST"]+'/users/' + 'upgrade_plan/'
    #    Mailer.deliver_manager_account_upgrade_mail(user,url)
    #  end
    #end

  end

  def self.reminder_after_a_week
    #@users=User.find(:all,:conditions=>"status='approved'")
    #for user in @users
    #  if user.plan.rank==1
    #    url = 'http://' + request.env["HTTP_HOST"]+'/users/' + 'upgrade_plan/'
    #    Mailer.deliver_manager_account_upgrade_mail(user,url)
    #  end
    #end
  end

end
