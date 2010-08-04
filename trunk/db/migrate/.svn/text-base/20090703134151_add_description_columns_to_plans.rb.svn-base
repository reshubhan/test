class AddDescriptionColumnsToPlans < ActiveRecord::Migration
  def self.up
    remove_column :plans, :notes
    add_column :plans, :no_of_views, :string
    add_column :plans, :no_of_emails, :string
    add_column :plans, :post_secondaries_to_buy, :boolean, :default => true
    add_column :plans, :post_secondaries_to_sell, :boolean, :default => true
    add_column :plans, :no_of_replies, :string
    
    plan = Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 1} )
    plan.no_of_views = "30"
    plan.no_of_emails = "-"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.duration = "One Year"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.duration = "Two Years"
    plan.save
    
    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.duration = "One Year"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.duration = "Two Years"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 2} )
    plan.no_of_views = "30"
    plan.no_of_emails = "-"
    plan.no_of_replies = "-"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.no_of_replies = "25 per Month"
    plan.duration = "One Year"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.no_of_replies = "25 per Month"
    plan.duration = "Two Years"
    plan.save
    
    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.no_of_replies = "Unlimited"
    plan.duration = "One Year"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.no_of_replies = "Unlimited"
    plan.duration = "Two Years"
    plan.save


    plan = Plan.find(:first, :conditions => {:name => 'Basic', :role_id => 3} )
    plan.no_of_views = "30"
    plan.no_of_emails = "-"
    plan.no_of_replies = "-"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.no_of_replies = "25 per Month"
    plan.duration = "One Year"
    plan.save
    
    plan = Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "5 per Month"
    plan.no_of_replies = "25 per Month"
    plan.duration = "Two Years"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '1 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.no_of_replies = "Unlimited"
    plan.duration = "One Year"
    plan.save

    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => '2 year'} )
    plan.no_of_views = "Unlimited"
    plan.no_of_emails = "Unlimited"
    plan.no_of_replies = "Unlimited"
    plan.duration = "Two Years"
    plan.save
    
  end

  def self.down
    add_column :plans, :notes, :string
    remove_column :plans, :no_of_views
    remove_column :plans, :no_of_emails
    remove_column :plans, :post_secondaries_to_buy
    remove_column :plans, :post_secondaries_to_sell
    remove_column :plans, :no_of_replies

    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 1, :duration => 'Two years'} ).update_attribute('duration', '2 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1, :duration => 'Two years'} ).update_attribute('duration', '2 year')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 2, :duration => 'Two years'} ).update_attribute('duration', '2 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2, :duration => 'Two years'} ).update_attribute('duration', '2 year')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => 'Two years'} ).update_attribute('duration', '2 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'One year'} ).update_attribute('duration', '1 year')
    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3, :duration => 'Two years'} ).update_attribute('duration', '2 year')
  end
end
