class UpgradePlanRefactored < ActiveRecord::Migration
  def self.up
    add_column :plans, :status, :boolean
    execute "TRUNCATE TABLE plans"
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Free', :discount => 0, :rank => '1',                                :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 995, :duration => 'One Year', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',     :no_of_views=>'100',:no_of_emails=>'10',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 1595, :duration => 'Two Year', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',     :no_of_views=>'100',:no_of_emails=>'10',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium', :fee => -1, :duration => 'One Year', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '4',:no_of_views=>'-1',:no_of_emails=>'-1',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )

    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',               :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 9995, :duration => 'One Year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 15995, :duration => 'Two Year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium',:fee => -1,:duration => 'One Year', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '4',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )

    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '',:role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',:no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 1995, :duration => 'One Year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus',:fee => 3195,:duration => 'Two Year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>0,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium', :fee => -1, :duration => 'One Year', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )

    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Free', :discount => 0, :rank => '1',                                :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 995, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',     :no_of_views=>'100',:no_of_emails=>'10',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium', :fee => 1495, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'-1',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',               :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Monthly', :fee => 499, :duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Monthly',:fee => 999,:duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Annual', :fee => 5988, :duration => '14 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Annual',:fee => 11988, :duration => '14 month',:role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid',:discount => 0,  :rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '',:role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',:no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Monthly', :fee => 499, :duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Monthly',:fee => 999,:duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Annual', :fee => 5988, :duration => '14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Annual',:fee => 11599,:duration => '14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,:rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
  end

  def self.down
    execute "TRUNCATE TABLE plans"
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Free', :discount => 0, :rank => '1',                                :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus', :fee => 995, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',     :no_of_views=>'100',:no_of_emails=>'10',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium', :fee => 1495, :duration => '12 months', :role_id => Role.find_by_title('Institutional Investor').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'-1',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',               :no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Monthly', :fee => 499, :duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100'  )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Monthly',:fee => 999,:duration => '1 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Annual', :fee => 5988, :duration => '14 month', :role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Annual',:fee => 11988, :duration => '14 month',:role_id => Role.find_by_title('Service Provider').id, :subscription_type => 'Paid',:discount => 0,  :rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Basic', :fee => 0, :duration => '',:role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Free', :discount => 0,  :rank => '1',:no_of_views=>'30',:no_of_emails=>'0',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'0' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Monthly', :fee => 499, :duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '2',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Monthly',:fee => 999,:duration => '1 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0, :rank => '3',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Plus Annual', :fee => 5988, :duration => ' 14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,  :rank => '4',:no_of_views=>'100',:no_of_emails=>'5',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    Plan.create(:status=>1,:post_secondaries_to_buy=>1,:post_secondaries_to_sell=>1,:name => 'Premium Annual',:fee => 11599,:duration => '14 month', :role_id => Role.find_by_title('Fund Manager').id, :subscription_type => 'Paid', :discount => 0,:rank => '5',:no_of_views=>'-1',:no_of_emails=>'50',:post_secondaries_to_buy=>'-1',:post_secondaries_to_sell=>'-1',:no_of_replies=>'0',:no_of_credits=>'100' )
    remove_column(:plans, :status)
  end
end
