class Sector < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_and_belongs_to_many :classified_funds
  has_and_belongs_to_many :funds

  def self.list
    find(:all, :order => 'name')
  end
end
