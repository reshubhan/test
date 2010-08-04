# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # render new.rhtml
  def new
    @title = "login"
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      user.update_attribute(:last_user_activity, Time.now)
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      unless current_user.has_role('Admin')
        case user.plan.role.title
        when ('Fund Manager')
          if (user.profile.organization_type.name=="Fund Manager"||user.profile.organization_type.name=="Fundless Sponsor")
            redirect_to :controller=>"companies", :action=>"new_directs_to_buy"
          elsif (user.profile.organization_type.name=="Fund of Funds"||user.profile.organization_type.name=="Asset Manager"||user.profile.organization_type.name=="Wealth Manager")
            redirect_to :controller=>"classified_funds", :action=>"new_fund_to_buy"
          else
            redirect_to :controller=>"classified_funds",:action=>"index"
          end
        when 'Institutional Investor'
          redirect_to :controller=>"classified_funds", :action=>"new_fund_to_buy"
        when 'Service Provider'
          if user.profile.organization_type.name=="Consultant"
            redirect_to :controller=>"classified_funds", :action=>"new_fund_to_buy"
          else
            redirect_to :controller=>"classified_funds",:action=>"index"
          end
        else
          redirect_to :controller=>"classified_funds",:action=>"index"
        end
      else
        redirect_to :controller => 'admin', :action => 'active_users'
      end
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      unless params[:fromFreeSignUpPage].blank?
        return(redirect_to url_for :controller => 'users', :action => 'new', :plan => '1', :role => '1')
      else
        redirect_to :controller => 'main', :action => 'index'
      end
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

  protected
  def note_failed_signin
    flash[:error] = "Incorrect login or password, try again!"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
