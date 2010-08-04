class AdditionalValuesInPlans < ActiveRecord::Migration
  def self.up
    Plan.find(:first, :conditions => {:name => 'Plus', :role_id => 3, :duration => '2 year'} ).update_attribute('fee', 2995)

    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 1} )
    plan.update_attribute('duration', '1 year')
    plan.update_attribute('fee', 1495)

    Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 2} ).update_attribute('duration', '1 year')
    
    plan = Plan.find(:first, :conditions => {:name => 'Premium', :role_id => 3} )
    plan.update_attribute('duration', '1 year')
    plan.update_attribute('fee', 3495)

    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid',:fee => 1995, :duration => '2 year',:notes => 'Unlimited secondary email contacts and access to entire TII site' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :duration => '2 year', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :fee => 4495, :duration => '2 year', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
  end

  def self.down
  end
end
