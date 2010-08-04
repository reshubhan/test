class AddRankToPlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :rank, :integer
    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 1} ).update_attribute('rank', 1)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => '1 year'} ).update_attribute('rank', 2)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => '2 year'} ).update_attribute('rank', 3)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => '1 year'} ).update_attribute('rank', 4)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => '2 year'} ).update_attribute('rank', 5)

    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 2} ).update_attribute('rank', 1)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '1 year'} ).update_attribute('rank', 2)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '2 year'} ).update_attribute('rank', 3)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => '1 year'} ).update_attribute('rank', 4)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => '2 year'} ).update_attribute('rank', 5)

    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 3} ).update_attribute('rank', 1)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => '1 year'} ).update_attribute('rank', 2)
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => '2 year'} ).update_attribute('rank', 3)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '1 year'} ).update_attribute('rank', 4)
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '2 year'} ).update_attribute('rank', 5)
  end

  def self.down
    remove_column :plans, :rank
  end
end
