class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  serialize :notification_emails, Hash

  attr_accessor :signature_firstname
  attr_accessor :email_confirmation
  attr_accessor :signature_lastname
  attr_accessor :i_agree
  attr_accessor :new_profile
  attr_accessor :money_manager
  belongs_to :organization_type
  validates_presence_of     :firstname
  validates_presence_of     :lastname
  validates_presence_of     :email_confirmation,:on=>:create
  validates_presence_of     :email
  validates_confirmation_of  :email 
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of :telephone
  #  validates_format_of :telephone, :message => "must be a valid telephone number.", :with => /^[\(\)0-9\- \+\.]{10,12}$/, :if => :is_telephone?

  validate do |profile|
    # profile.errors.add_to_base("Zip Code is too long(Maximum is 10 characters)") if  profile.zip and profile.zip.length>10
    profile.errors.add_to_base("Organization Name is too long(Maximum is 200 characters)") if profile.organization_name and profile.organization_name.length>200
    profile.errors.add_to_base("First Name is too short(Minimum is 3 characters)") if profile.firstname.length<3 and profile.firstname.length !=0
    profile.errors.add_to_base("Last Name is too short(Minimum is 3 characters)") if profile.lastname.length<3 and profile.lastname.length !=0
    profile.errors.add_to_base("First Name is too long(Maximum is 40 characters)") if profile.firstname.length>40
    profile.errors.add_to_base("Last Name is too long(Maximum is 40 characters)") if profile.lastname.length>40
    profile.errors.add_to_base("Job Title is too long(Maximum is 100 characters)") if  profile.job_title and profile.job_title.length>100
  end

  def is_telephone?
    return true unless telephone.blank?
  end

  def validate
    if @new_profile
      errors.add_to_base("Terms and Conditions and Legal Policies not accepted") if self.i_agree=='0'
    end
  end

  def fullname
    firstname+ " " + lastname
  end

  def editing_profile?
    return editing_profile
  end

  DESIGNATIONS = ["CIO","Director","Associate","Analyst","CEO","Manager","others"]
end
