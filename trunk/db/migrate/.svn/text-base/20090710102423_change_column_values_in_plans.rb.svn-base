class ChangeColumnValuesInPlans < ActiveRecord::Migration
  def self.up
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'One Year'} ).update_attribute('no_of_emails', '10 per Annum')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'Two Years'} ).update_attribute('no_of_emails', '10 per Annum')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'One Year'} ).update_attribute('no_of_emails', '10 per Annum')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'Two Years'} ).update_attribute('no_of_emails', '10 per Annum')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'One Year'} ).update_attribute('no_of_emails', '10 per Annum')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'Two Years'} ).update_attribute('no_of_emails', '10 per Annum')
  end

  def self.down
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'One Year'} ).update_attribute('no_of_emails', '5 per Month')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'Two Years'} ).update_attribute('no_of_emails', '5 per Month')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'One Year'} ).update_attribute('no_of_emails', '5 per Month')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'Two Years'} ).update_attribute('no_of_emails', '5 per Month')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'One Year'} ).update_attribute('no_of_emails', '5 per Month')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'Two Years'} ).update_attribute('no_of_emails', '5 per Month')
  end
end
