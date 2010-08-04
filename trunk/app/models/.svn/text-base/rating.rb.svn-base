class Rating < ActiveRecord::Base
  validates_numericality_of :performance, :less_than_or_equal_to => 5, :greater_than_or_equal_to => 0
  validates_numericality_of :team, :less_than_or_equal_to => 5, :greater_than_or_equal_to => 0
  validates_numericality_of :strategy, :less_than_or_equal_to => 5, :greater_than_or_equal_to => 0
  validates_numericality_of :terms, :less_than_or_equal_to => 5, :greater_than_or_equal_to => 0
  validates_numericality_of :overall, :less_than_or_equal_to => 5, :greater_than_or_equal_to => 0
  
  belongs_to :manager

  def self.find_latest_rating(current_user, manager)
    find(:first, :conditions => {:user_id => current_user, :manager_id => manager}, :order => "created_at desc" )
  end
end
