class Fund < ActiveRecord::Base
  attr_accessor :manager_name
  attr_accessor :user_login
  attr_accessor :admined
  validates_presence_of     :manager_id, :message => "is either invalid or blank"
  #validates_presence_of     :manager_name, :message => "is either invalid or blank"
  validates_presence_of     :user_login, :message => "name is required", :if => :admined
  validates_presence_of     :name
  validates_length_of       :name, :within => 0..50
  validates_uniqueness_of   :name, :scope => [:manager_id]
  validates_presence_of     :size
  validates_presence_of     :year
  #  validates_presence_of     :portfolio
  #  validates_presence_of     :overview
  validates_numericality_of :size, :greater_than => 0, :less_than => 100000
  # validates_presence_of     :irr
  # validates_presence_of    :manager_id
  validates_presence_of :currency
  #  validates_presence_of :sector
  #  validates_numericality_of :irr, :if => :irr
  #  validates_numericality_of :multiple, :if => :multiple
  
  belongs_to :manager
  belongs_to :user
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  has_many :secondaries
  has_many :classified_funds
  has_and_belongs_to_many :sectors
  has_and_belongs_to_many :assets
  has_many :compainies
  
  def user_login
    user.login if user
  end
  
  def user_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end

  def manager_name
    manager.name if manager
  end
  
  def manager_name=(name)
    self.manager = Manager.find_by_name(name) unless name.blank?
  end
  
  def self.list
    find(:all, :order => 'name')
  end

  def Fund.year_options
    options = [{:val => ''}]
    (Date.today.year + 1 ).downto 1970 do |y|
      options.push({:val => y, :label => y.to_s})
    end
    options
  end

  def self.total_size(manager_id)
    funds = find(:all, :conditions => {:manager_id => manager_id})
    total_size=0
    funds.each { |f|
      total_size += f.size
    }
    return total_size
  end

  def self.max_size_for_scroller
    fundWithMaxSize = Fund.find(:first, :order => 'size desc')
    return fundWithMaxSize.blank? ? 100 : self.roundup(fundWithMaxSize.size).to_i
  end

  def self.roundup(number)
    return number if number % 10 == 0   # already a factor of 10
    return number + 10 - (number % 10)  # go to nearest factor 10
  end

  def has_asset?(asset)
    if assets and assets.size>0
    assets.each do |a| return true if a.id == asset end
    end
    return false
  end

  def get_asset_names
    names = []
    assets.each { |asset| names << asset.name }
    names.join(', ')
  end

  def get_sector_names
    names = []
    sectors.each { |sector| names << sector.name }
    names.join(', ')
  end
end
