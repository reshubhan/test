# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'production'

#RMAGICK_BYPASS_VERSION_TEST = true

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'chronic', :lib => false, :source => 'http://gems.github.com'
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'
  config.gem "searchlogic"
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug
   config.after_initialize do
    ExceptionNotifier.exception_recipients = %w(amarsingh@neevtech.com,rahulsingh@neevtech.com)
    ExceptionNotifier.sender_address = %(ti.dyndns.org)
    ExceptionNotifier.email_prefix = "[My Application ERROR] "
  end
  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  # config.time_zone = 'UTC'
  
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_trustedinsight_session',
    :secret      => '3a14db0a5cf384adecbb41f353b819223e431cb60de57e15e395aa64645e1c96ed96f46db75cca53d51665eeb14feff18c1e57342f03a1b4bb3dba82b33dff0c'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  # config.action_controller.session_store = :active_record_store
  config.action_controller.page_cache_directory = "#{RAILS_ROOT}/public/system/pages"

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.gem 'mislav-will_paginate' , :version => '~> 2.3.2' ,:lib => 'will_paginate' , :source => 'http://gems.github.com'
  config.gem "adzap-ar_mailer", :lib => 'action_mailer/ar_mailer'
end
require 'rubygems'
require 'active_merchant'
require 'RMagick'
require 'money'
require 'paypal'
require "will_paginate"
require 'action_mailer/ar_mailer'
APP_CONFIG = YAML::load(File.open("#{RAILS_ROOT}/config/config.yml"))
WillPaginate::ViewHelpers.pagination_options[:renderer] = 'RemoteLinkRenderer'

Time::DATE_FORMATS[:default] = "%B %d %Y"

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.sendmail_settings = {
  :location       => '/usr/sbin/sendmail',
  :arguments      => '-i -t '
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "utf-8"

ActionMailer::Base.smtp_settings = {
  :tls => false,
  :address => '10.0.15.3',
  :port => 25,
  :domain => 'neevtech.com',
  :authentication => :login,
  :user_name => 'neev@smtp.neevtech.com',
  :password => 'sp2English'
}
