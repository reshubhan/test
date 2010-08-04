# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  helper_method :current_user,:get_session_admin,:get_cookie_admin
  # Pick a unique cookie name to distinguish our session data from others'
  # session :session_key => '_duplays_session_id'
  # ensure_application_is_installed_by_facebook_user

  filter_parameter_logging :fb_sig_friends
  local_addresses.clear
  helper :all # include all helpers, all the time
  exception_data :additional_data
  layout 'main'
  include SimpleCaptcha::ControllerHelpers
  WillPaginate::ViewHelpers.pagination_options[:previous_label] = "<span class='previous'></span>"
  WillPaginate::ViewHelpers.pagination_options[:next_label] = "<span class='next'></span>"
  
  session_times_out_in 60.minutes, :after_timeout => :timeout_message

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '81f5611a86b0f77cba525b7af3f4ecb3'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  def has_access?(obj)
    (obj.user_id == current_user.id or current_user.has_role('Admin')) ? true : false
  end
  
  def reset_filter_hash
    #    if not session[:filter_hash]
    #      session[:filter_hash] = Hash.new
    #    end
    #    session[:filter_hash]['time'] = 'all'
    #    session[:filter_hash]['browse_by'] = 'popular'
    #    session[:filter_hash]['geo'] = 'all'
    #    session[:filter_hash]['sectors'] = 'all'
    #    session[:filter_hash]['asset'] = 'all'
    #    session[:filter_hash]['open'] = false
    #    session[:filter_hash]['buyer'] = false
    #    session[:filter_hash]['seller'] = false
    #    session[:filter_hash]['size_min'] = 0
    #    session[:filter_hash]['size_max'] = Fund.max_size_for_scroller
  end
  
  def log_error(exception)
    super(exception)
    begin
      if exception.message.scan('no route found to match').size == 0
        #        ErrorMailer.deliver_snapshot(
        #          exception,
        #          clean_backtrace(exception),
        #          (@session ? @session.instance_variable_get("@data") : session.instance_variable_get("@data")),
        #          (@params ? @params : params),
        #          (@request ? @request.evn : request.env))
      end
    rescue => e
      #logger.error(e)
    end
  end

  protected

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action"
    return redirect_back_or_default('/')
  end

  def timeout_message
    flash[:notice] = "You have been logged out. Please login again to use the application."
    return redirect_back_or_default('/')
  end

  def additional_data
    { :document => @document,
      :person => @person }
  end

end
