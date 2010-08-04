ActionController::Routing::Routes.draw do |map|
  map.resources :emails

  map.resources :notifications

  map.resources :adverts
  
  map.resources :transaction_types

  map.resources :answers

  map.resources :statistics

  map.resources :tickers

  map.resources :remove_image_columns_from_assets_and_geographies

  map.resources :webinars

  map.resources :organization_types

  map.resources :sectors

  map.resources :currencies

  map.resources :orders

  map.register '/register', :controller => 'users', :action => 'new',:type=>'create'
  map.interested '/users/interested', :controller => 'users', :action => 'interested'
  map.forgot_password '/forgot-password', :controller => 'users', :action => 'forgot_password'
  map.reset_password 'reset_password', :controller => 'users', :action => 'reset_password'
  map.set_password 'set_password', :controller => 'users', :action => 'set_password'
  map.single_invite '/single_invite', :controller => 'users', :action => 'single_invite'
  map.add_invite '/add_invite', :controller => 'users', :action => 'add_invite'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.reset 'reset', :controller => 'users', :action => 'reset'
  map.ipn "/users/ipn", :controller=>"users", :action=>"ipn"
  map.survey "/survey", :controller=>"users", :action=>"survey"
  map.mail_after_week "/users/mail_after_week", :controller=>"users", :action=>"mail_after_week"
  map.read_status "/users/read_status", :controller=>"users", :action=>"read_status"
  map.delete_messages "/users/delete_messages", :controller=>"users", :action=>"delete_messages"
  map.sent_received_messages "/users/sent_received_messages", :controller=>"users", :action=>"sent_received_messages"
  map.mark_unread "/users/mark_unread", :controller=>"users", :action=>"mark_unread"
  map.auto_complete_user_login '/users/auto-complete-user-login', :controller=>'users', :action=>'auto_complete_user_login'
  map.cancel_registration 'cancel-registration/:id', :controller => "users", :action => "cancel_registration"
  map.payment_received '/users/payment_received', :controller=>'users', :action=>'payment_received'
  map.contact_list '/users/contact_list', :controller=>'users', :action=>'contact_list'
  map.send_mails '/users/send_mails', :controller=>'users', :action=>'send_mails'
  map.user_profile '/profile', :controller => 'users', :action => 'edit_profile'
  map.update_profile '/users/update_profile/:id', :controller => 'users', :action => 'update_profile'
  map.upgrade_plan '/users/upgrade_plan/', :controller => 'users', :action => 'upgrade_plan'
  map.change_password '/change-password', :controller => 'users', :action => 'change_password'
  map.forgot_password_mail 'forgot_password/mail', :controller => 'users', :action => 'send_forgot_password_mail'
  map.connect 'facebook/accept_invite/:id', :controller => 'facebook', :action=> 'accept_invite'

  # # ActionController::Routing::Routes.draw do |map|
  map.resources :users
  # # end

  map.connect '/connect', :controller => 'facebook', :action => 'connect'
  map.show_question '/questions/show_question', :controller => 'questions', :action => 'show_question'
  map.new_rank '/questions/new_rank', :controller => 'questions', :action => 'new_rank'
  map.edit_add_field '/questions/edit_add_field', :controller => 'questions', :action => 'edit_add_field'
  map.add_radio_field '/questions/add_radio_field', :controller => 'questions', :action => 'add_radio_field'
  map.show_options '/questions/show_options', :controller => 'questions', :action => 'show_options'
  map.hide_options '/questions/hide_options', :controller => 'questions', :action => 'hide_options'
  map.list_answers '/list_answers', :controller => 'questions', :action => 'list_answers'
  map.more_options '/questions/more_options', :controller => 'questions', :action => 'more_options'
  map.question_type '/questions/question_type', :controller => 'questions', :action => 'question_type'
  map.add_field '/questions/add_field', :controller => 'questions', :action => 'add_field'
  map.user_answers '/user_answers', :controller => 'answers', :action => 'user_answers'
  map.list_question '/list_question', :controller => 'questions', :action => 'list_question'
  map.remove_question '/questions/remove_question', :controller => 'questions', :action => 'remove_question'
  map.resources :questions
  map.resources :pages
  map.new_directs_to_buy '/companies/new_directs_to_buy', :controller => 'companies', :action => 'new_directs_to_buy'
  map.params_saved '/companies/params_saved', :controller => 'companies', :action => 'params_saved'
  map.show_ticker '/tickers/show_ticker', :controller=>'tickers', :action=>'show_ticker'
  map.remove_ticker '/tickers/remove_ticker', :controller=>'tickers', :action=>'remove_ticker'
  map.show_statistic '/statistics/show_statistic', :controller=>'statistics', :action=>'show_statistic'
  map.remove_statistic '/statistics/remove_statistic', :controller=>'statistics', :action=>'remove_statistic'
  map.inbox_messages "/messages/inbox_messages", :controller=>"messages", :action=>"inbox_messages"
  map.sent_messages "/messages/sent_messages", :controller=>"messages", :action=>"sent_messages"
  map.not_interested "/messages/not_interested", :controller=>"messages", :action=>"not_interested"
  map.mark_message_read "/messages/mark_message_read", :controller=>"messages", :action=>"mark_message_read"
  map.mark_message_unread "/messages/mark_message_unread", :controller=>"messages", :action=>"mark_message_unread"
  map.search_string "/messages/search_string", :controller=>"messages", :action=>"search_string"
  map.confirm "/orders/confirm",:controller=>"orders", :action=>"confirm"
  map.index_results "/managers/index_results",:controller=>"managers", :action=>"index_results"
  map.index_results "/companies/index_results",:controller=>"companies", :action=>"index_results"
  map.index_results "/secondaries/index_results",:controller=>"secondaries", :action=>"index_results"
  map.listing "/secondaries/listing",:controller=>"secondaries", :action=>"listing"
  map.index_results 'classified_funds/index_results', :controller=>'classified_funds', :action=>'index_results'
  map.params_saved 'classified_funds/params_saved', :controller=>'classified_funds', :action=>'params_saved'
  map.check_assets 'classified_funds/check_assets', :controller=>'classified_funds', :action=>'check_assets'
  map.check_assets 'companies/check_assets', :controller=>'companies', :action=>'check_assets'
  map.directs_to_investment_criteria 'companies/directs_to_investment_criteria', :controller=>'companies', :action=>'directs_to_investment_criteria'
  map.profile_company_list 'companies/profile_company_list', :controller=>'companies', :action=>'profile_company_list'
  map.asset_images 'assets/asset_images', :controller=>'assets', :action=>'asset_images'
  map.default_asset 'assets/default_asset', :controller=>'assets', :action=>'default_asset'
  map.activate_asset 'assets/activate_asset', :controller=>'assets', :action=>'activate_asset'
  map.geography_images 'geograhies/geography_images', :controller=>'geographies', :action=>'geography_images'
  map.edit_image 'geograhies/edit_image', :controller=>'geographies', :action=>'e'
  map.connect  'classified_funds/new_fund_to_buy', :controller=>'classified_funds', :action=>'new_fund_to_buy'
  map.profile_fund_list  'classified_funds/profile_fund_list', :controller=>'classified_funds', :action=>'profile_fund_list'
  map.fund_to_direct_preference  'classified_funds/fund_to_direct_preference', :controller=>'classified_funds', :action=>'fund_to_direct_preference'
  #classified funds
  map.index_results "/companies/list",:controller=>"companies", :action=>"list"
  map.resources :companies
  map.resources :messages
  map.update_url "/managers/update_url", :controller => "managers", :action => "update_url"
  map.connect "/payments/index.:format", :controller=>'payments', :action=>'index'
  map.resources :comments
  map.getfunds 'secondaries/getfunds', :controller=>'secondaries', :action=>'getfunds'
  map.profile_secondary_list 'secondaries/profile_secondary_list', :controller=>'secondaries', :action=>'profile_secondary_list'
  map.connect '/secondaries/secondary_mail/:id', :controller=>'secondaries', :action=>'secondary_mail'
  map.resources :secondaries
  map.resources :attributes
  map.resources :geographies
  map.resources :assets
  map.resources :classified_funds
  map.delete_postings_classified_fund 'classified_funds/delete_postings/:user_id', :controller => 'classified_funds', :action => 'delete_postings'
  #map.delete_postings_secondary 'secondaries/delete_postings/:user_id', :controller => 'secondaries', :action => 'delete_postings'
  map.delete_postings_company 'companies/delete_postings/:user_id', :controller => 'companies', :action => 'delete_postings'
  map.filter_results '/secondaries/filter_results', :controller=>'secondaries', :action=>'filter_results'
  map.manager_updates '/admin/manager_updates', :controller => 'admin', :action => 'manager_updates'
  map.db_backup '/admin/db_backup', :controller => 'admin', :action => 'db_backup'
  map.upload_classified_funds '/admin/classified_funds', :controller => 'admin', :action => 'classified_funds'
  map.new_funds '/classified_funds/new_funds', :controller => 'classified_funds', :action => 'new_funds'
  map.deleted_funds '/funds/deleted_funds', :controller=>'funds', :action=>'deleted_funds'
  map.deleted_managers '/managers/deleted_managers', :controller=>'managers', :action=>'deleted_managers'
  map.connect 'classified_funds/getfunds', :controller=>'classified_funds', :action=>'getfunds'
  map.connect 'classified_funds/get_manager_url', :controller=>'classified_funds', :action=>'get_manager_url'
  map.resources :funds
  map.approve_flagged_comment '/comments/approve/:id', :controller => "comments", :action => 'approve_flagged_comment'
  map.disapprove_flagged_comment '/comments/disapprove/:id', :controller => "comments", :action => 'disapprove_flagged_comment'
  map.rate_comment '/comments/rate_comment/:id', :controller => "comments", :action => 'rate_comment'
  map.add_flag '/comments/add_flag/:id', :controller => "comments", :action => 'add_flag'
  map.connect '/managers/list', :controller=>'managers', :action=>'list'
  map.connect '/managers/filter_results/:id', :controller=>'managers', :action=>'filter_results'
  map.connect '/secondaries/list/:id', :controller=>'secondaries', :action=>'index'
  map.approve_secondary '/secondaries/approve_secondary', :controller=>'secondaries', :action=>'approve_secondary'
  map.deleted_secondary '/secondaries/deleted_secondary', :controller=>'secondaries', :action=>'deleted_secondary'
  map.connect '/secondaries/upload/:id', :controller=>'secondaries', :action=>'new'
  map.connect '/classified_funds/list/:type', :controller=>'classified_funds', :action=>'index'
  map.connect '/classified_funds/upload/:id', :controller=>'classified_funds', :action=>'new'
  map.connect '/companies/upload/:id', :controller=>'companies', :action=>'new'
  map.resources :managers, :collection => {:auto_complete_for_manager_name => :get }#, :filter_results => :any
  map.simple_captcha '/simple-captcha/:action', :controller => 'simple_captcha'
  map.fund_report '/fund-report', :controller=>'funds', :action=>'fund_report'
  map.fund_list '/fund/list/:id', :controller=>'funds', :action=>'index'
  # map.secondary_list '/secondary/list/:id', :controller=>'secondaries', :action=>'listing'
  map.auto_complete_manager_name '/managers/auto-complete-manager-name', :controller=>'managers', :action=>'auto_complete_manager_name'
  map.review_manager '/manager/review/:id', :controller=>'managers', :action=>'review_manager'
  map.manager_profile '/manager/:id', :controller=>'managers', :action=>'show'
  map.manager_report '/manager-report', :controller=>'managers', :action=>'manager_report'
  map.resources :managers
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.upload '/admin/upload/:id', :controller => "admin", :action => 'upload'
  map.formatted_active_users '/admin/export_active_users.xls', :controller => 'admin', :action => 'export_active_users', :format => 'xls'
  map.resource :session
  map.root :controller => "main", :action => 'index'
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end