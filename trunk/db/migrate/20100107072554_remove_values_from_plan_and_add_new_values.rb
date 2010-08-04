class RemoveValuesFromPlanAndAddNewValues < ActiveRecord::Migration
  def self.up
    execute "TRUNCATE TABLE plans"
    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Free', :discount => 0, :rank => '1',                                :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:name => 'Plus', :fee => 995, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',     :no_of_views=>'100',:no_of_emails=>'10',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:name => 'Premium', :fee => 1495, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'-1',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    

    Plan.create(:name => 'Basic', :fee => 0, :duration => '', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',               :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:name => 'Plus Monthly', :fee => 500, :duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:name => 'Premium Monthly',:fee => 1000,:duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:name => 'Plus Annual', :fee => 6000, :duration => '14 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:name => 'Premium Annual',:fee => 12000, :duration => '14 month',:role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid',:discount => 0,  :rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )

    Plan.create(:name => 'Basic', :fee => 0, :duration => '',:role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',:no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:name => 'Plus Monthly', :fee => 500, :duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:name => 'Premium Monthly',:fee => 1000,:duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:name => 'Plus Annual', :fee => 6000, :duration => ' 14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:name => 'Premium Annual',:fee => 12000,:duration => '14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,:rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
  end

  def self.down
    execute "TRUNCATE TABLE plans"
    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only rankings and reviews' )
    Plan.create(:name => 'Plus', :fee => 995, :duration => '1 year', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts; increase to Premium status by adding 25 manager ratings and reviews' )
    Plan.create(:name => 'Plus', :fee => 1595, :duration => '2 year', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts; increase to Premium status by adding 25 manager ratings and reviews' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )

    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only reviews' )
    Plan.create(:name => 'Plus', :fee => 9995, :duration => '1 year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Plus', :fee => 15995, :duration => '2 year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )

    Plan.create(:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0, :notes => 'Only reviews' )
    Plan.create(:name => 'Plus', :fee => 1995, :duration => '1 year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Plus', :fee => 3195, :duration => '2 year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 20, :notes => 'Up to 5 secondary email contacts' )
    Plan.create(:name => 'Premium', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :notes => 'Unlimited secondary email contacts and access to entire TII site' )
  end
end
