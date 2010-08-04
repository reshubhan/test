class ChangeValueOfFeesInPlans < ActiveRecord::Migration
  def self.up
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '1 year'} ).update_attribute('fee', nil)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '2 year'} ).update_attribute('fee', nil)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '1 year'} ).update_attribute('fee', nil)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '2 year'} ).update_attribute('fee', nil)
  end

  def self.down
  end
end
