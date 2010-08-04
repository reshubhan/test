class ChangeValuesInPlans < ActiveRecord::Migration
  def self.up
    plans = Plan.find(:all)
    plans.each do |plan|
      plan.no_of_emails = "0"
      plan.no_of_views = "0"
      plan.no_of_replies = "0"
      plan.save
    end

    change_column :plans, :no_of_emails, :integer
    change_column :plans, :no_of_views, :integer
    change_column :plans, :no_of_replies, :integer
    
    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 1} ).update_attribute("no_of_views", "30")
    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 1} ).update_attribute("no_of_emails", "0")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'One Year'} ).update_attribute("no_of_views", "100")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'One Year'} ).update_attribute("no_of_emails", "10")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'Two Years'} ).update_attribute("no_of_views", "200")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'Two Years'} ).update_attribute("no_of_emails", "20")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'One Year'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'One Year'} ).update_attribute("no_of_emails", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'Two Years'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'Two Years'} ).update_attribute("no_of_emails", "-1")

    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 2} ).update_attribute("no_of_views", "30")
    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 2} ).update_attribute("no_of_emails", "0")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'One Year'} ).update_attribute("no_of_views", "100")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'One Year'} ).update_attribute("no_of_emails", "10")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'Two Years'} ).update_attribute("no_of_views", "200")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'Two Years'} ).update_attribute("no_of_emails", "20")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'One Year'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'One Year'} ).update_attribute("no_of_emails", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'Two Years'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'Two Years'} ).update_attribute("no_of_emails", "-1")

    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 3} ).update_attribute("no_of_views", "30")
    Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 3} ).update_attribute("no_of_emails", "0")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'One Year'} ).update_attribute("no_of_views", "100")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'One Year'} ).update_attribute("no_of_emails", "10")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'Two Years'} ).update_attribute("no_of_views", "200")
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'Two Years'} ).update_attribute("no_of_emails", "20")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'One Year'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'One Year'} ).update_attribute("no_of_emails", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'Two Years'} ).update_attribute("no_of_views", "-1")
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'Two Years'} ).update_attribute("no_of_emails", "-1")
  end

  def self.down
  end
end
