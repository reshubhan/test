class PopulatePlans < ActiveRecord::Migration
  def self.up
    add_column :plans, :notes, :string
    add_column :plans, :discount, :integer
    change_column :plans, :duration, :string
    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Invester').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only rankings and reviews' )
    Plan.create(:name => 'Plus', :fee => 995, :duration => '1 year', :role_id => Role.find_by_title('Institutional Invester').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts; increase to Premium status by adding 25 manager ratings and reviews' )
    Plan.create(:name => 'Plus', :fee => 1595, :duration => '2 year', :role_id => Role.find_by_title('Institutional Invester').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts; increase to Premium status by adding 25 manager ratings and reviews' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Institutional Invester').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
    
    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only reviews' )
    Plan.create(:name => 'Plus', :fee => 9995, :duration => '1 year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Plus', :fee => 15995, :duration => '2 year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
    
    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only reviews' )
    Plan.create(:name => 'Plus', :fee => 1995, :duration => '1 year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Plus', :fee => 3195, :duration => '2 year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
    
  end

  def self.down
    remove_column :plans, :notes
    change_column :plans, :duration, :integer
    remove_column :plans, :discount
  end
end
