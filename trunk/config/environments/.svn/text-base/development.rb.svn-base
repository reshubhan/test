# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = false
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Do care if the mailer can't send
config.action_mailer.raise_delivery_errors = true

# set delivery method to :smtp, :sendmail or :test

#config.action_mailer.smtp_settings = {
#  :address => '192.168.1.84',
#  :port => 25,
#  :domain => 'neevtech.com',
#  :authentication => :login,
#  :user_name => 'neev@smtp.neevtech.com',
#  :password => 'sp2English'
#}


config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address => '8.17.173.178',
  :port => 25,
  :domain => '8.17.173.178',
  :authentication => :login,
  :user_name => 'jill',
  :password => 'perjmymspu'
}

config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  ::GATEWAY = ActiveMerchant::Billing::PaypalExpressRecurringGateway.new(
    :login => "ravefo_1263280183_biz_api1.yahoo.com",
    :password => "REETYRVTBTAJ2FER",
    :signature => "AVqBeOYBoTQi2Q7B0V-DbrUD833QAgbO0GOdTyS0Bqp4T.hz3rQjwB6p"
  )
  ::JUST_PAY_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    :login => "ravefo_1263280183_biz_api1.yahoo.com",
    :password => "REETYRVTBTAJ2FER",
    :signature => "AVqBeOYBoTQi2Q7B0V-DbrUD833QAgbO0GOdTyS0Bqp4T.hz3rQjwB6p"
  )
end
