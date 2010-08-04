class Geography < ActiveRecord::Base
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :managers
  has_many :classified_funds
  has_many :companies
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  has_and_belongs_to_many :adverts
  belongs_to :user
  #belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  def self.list
    find(:all, :order => 'name')
  end
end
