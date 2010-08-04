class UsersController < ApplicationController
  layout :users_layout
  before_filter :login_required, :except => [:newmailertemp,:index, :new, :create, :payment_received, :forgot_password, :ipn, :setup_paypal_keys, :forgot_password_mail, :reminder, :activate,:check_availability,:reset_password,:set_password]
  after_filter :store_location, :only => [:edit_profile]
  
  def users_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end

  def reminder
    render :layout => false
  end

  def send_mails
    ids=nil
    ids=[]
    emails=params[:recipient][:list].split(",")
    emails.each do |email|
      em=email.split("<")
      ids << em[1]
    end
    mail_ids=nil
    mail_ids=[]
    ids.each do |id|
      mail_ids << id.split(">")
    end
    mail_ids.each do |id|
      invite=Invites.create(:user_id => current_user.id,:receipient_email_id => id,:invite_type => "email")
      invite.save
      url_interested = 'http://' + request.env["HTTP_HOST"]+'/users' +'/interested/'+invite.id.to_s
      Mailer.deliver_invite_freinds(current_user.profile.email,current_user.fullname,id,url_interested)
    end
    flash[:notice]="Your invites has been sent."
    redirect_to :controller => "users",:action => "edit_profile"
  end

  def single_invite
    ids=[]
    flag=false
    unless params[:single_invite].join().to_s.blank?
      if params[:single_invite].join().include?(",")|| params[:single_invite].join().include?(" ")
        flash[:notice]="Please enter  email Id without #{params[:single_invite].join().include?(",")?'comma':'space'}."
        redirect_to :back
      else
        params[:single_invite].each do |id|
          unless id.blank?
            if id.match( /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/)
              invite=Invites.create(:user_id => current_user.id,:receipient_email_id => id,:invite_type => "email")
              invite.save
              url_interested = 'http://' + request.env["HTTP_HOST"]+'/users' +'/interested/'+invite.id.to_s
              Mailer.deliver_invite_freinds(current_user.profile.email,current_user.fullname,id.match( /([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})/),url_interested)
            else
              ids << id
              ids << ","
              flag=true
            end
          else
            
          end
        end
        if flag==true
          flash[:notice]="Please enter the correct email id for : #{ids}."
        else
          flash[:notice]="Your invites has been sent."
        end
        redirect_to :controller => "users",:action => "edit_profile"
      end
    else
      flash[:notice]="Please enter atleast one email Id."
      redirect_to :controller => "users",:action => "edit_profile"
    end
  end

  def add_invite
    @value=rand(9999)
    render(:update) do |page|
      page.insert_html :bottom, "single_invite",:partial => "add_invite"
      render :nothing =>true
    end
  end
 


  def interested
    invite=Invites.find(params[:id])
    if invite
      invite.update_attribute(:status, true)
      flash[:notice]="You have replied that you have interest in this Invitation ."
      redirect_to :controller => "main" ,:action => :index
    else
      render  :nothing => true,:text => "You were not sent invitation."
    end
    
  end

  def index
    @users = User.find(:all, :conditions => ['login LIKE ?', "%#{params[:login_search]}%"]) if params[:login_search]
    respond_to do |format|
      format.js { render :layout => false }
      format.html # index.html.erb
    end
  end

  def read_status
    ids = params[:message_id].split(",")
    render :update do |page|
      ids.each do |id|
        message=Message.find_by_id(id)
        if params[:type]=="inbox"
          message.update_attribute("receiver_read", true)
        else
          message.update_attribute("sender_read", true)
        end
        message.save
        page.call :mark_read, "row_#{message.id}"
      end
    end
  end


  def mark_unread
    ids = params[:message_id].split(",")
    render :update do |page|
      ids.each do |id|
        message=Message.find_by_id(id)
        if params[:type]=="inbox"
          message.update_attribute("receiver_read", false)
        else
          message.update_attribute("sender_read", false)
        end
        message.save
        page.call :mark_unread, "row_#{message.id}"
      end
    end
  end

  def delete_messages
    ids = params[:message_id].split(",")
    ids.each do |id|
      message=Message.find_by_id(id)
      if params[:type]=="inbox"
        message.update_attribute("receiver_delete_status", false)
      else
        message.update_attribute("sender_delete_status", false)
      end
      message.save
    end
    if params[:type]=="inbox"
      redirect_to :action=>"inbox_messages",:controller=>"messages"
    else
      redirect_to :action=>"sent_messages",:controller=>"messages"
    end
  end
 
  def new
    if params[:type]=="create"
      @managercheck='showregistration'
      logout_keeping_session!
      exit = false
      @profile = Profile.new(params[:profile])
      @profile.organization_type_id=params[:organization_type]
      @profile.approved = true
      @profile.approved_at = Date.today
      @profile.new_profile=1
      @role = Role.find(params[:role])
      @user = User.new(params[:user])
      @user.first_time_login=1;
      if @role.id == 2 #Money Manager
        @profile.money_manager = 1
        @user.money_manager = 1
      end
      if @user.plan
        @user.emails = @user.plan.no_of_emails
        @user.replies = @user.plan.no_of_replies
        @user.views = @user.plan.no_of_views
      end
      @user.roles << @role
      @user.profile = @profile
      if( !params[:manager_id].blank? )
        manager = Manager.find(params[:manager_id])
        @user.manager_id = manager.id unless manager.nil?
        @profile.organization_name = manager.name if @profile.money_manager==1
      end
      success1 = @user.valid?
      success2 = @profile.valid?
      unless simple_captcha_valid?
        @user.errors.add("captcha", "is invalid")
      else
        if success1 and success2
          @user.email_alias = "#{@user.login}@trustedinsightinc.com"
          @user.activation_code = @user.random_password(10)
          @user.save
          self.current_user = @user # !! now logged in
          if @user.plan.name == "Basic" or @user.plan.fee==0 or @user.plan.fee.blank? or @user.plan.fee<0
            if @user.plan.fee.blank?
              flash[:notice] = "Please contact Trusted Insight for your annual fee payment."
              self.current_user=nil
            end
          else
            return(redirect_to new_order_url+"/"+@user.id.to_s)
          end
          if @user.plan.fee<=0
            url = 'http://' + request.env["HTTP_HOST"]+'/activate/' + @user.activation_code
            Mailer.deliver_user_details(@user)
            begin
              Mailer.deliver_account_activation_mail(@user, url)
              
            rescue => e
              logger.error "Mailing error : #{e.inspect}"
            end
            flash[:notice] = 'A mail has been sent to your account.'
            logout_keeping_session!
          end
          redirect_to '/'
        end
      end
    else
      redirect_to "/" if current_user
      @user = User.new
      @profile = Profile.new
      if not params[:role]
        redirect_to :root
      elsif params[:role] && !params[:plan]
        redirect_to :controller => 'main', :action => 'select_plan', :role_id => params[:role]
      else
        @plan=params[:plan]
        @user.plan_id = params[:plan].to_i
        @role = Role.find(params[:role])
        @managercheck='showregistration'
        if @role.title == 'Institutional Investor'
          @title = 'Institutional Investor Sign Up'
        elsif @role.title == 'Service Provider'
          @title = 'Service Provider Sign Up'
        else @role.title == 'Fund Manager'
          @title = 'Money Manager Sign Up'
          @manager=Manager.find(:first, :conditions => "id = '#{params[:manager_id]}' and status='approved'") if params[:manager_id]
          @user.manager=@manager
          @managercheck='showregistrationfalse' unless @manager
        end
      end
    end
  end

  
  def check_availability
    @manager = Manager.find(:first, :conditions => "name = '#{params[:manager_name]}'")
    if @manager
      flash[:notice] = "Manager is present. Please signup."
    else
      flash[:error] = "Manager is not present. Please add."            
    end
    @role= params[:role]
    @plan=params[:plan]
    if @manager
      redirect_to :action=>'new',:role=>@role,:plan=>@plan,:manager_id => @manager.id
    else
      redirect_to :action=>'new',:role=>@role,:plan=>@plan,:manager_id => nil
    end
  end
  

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.approved?
      flag = user.start_date.to_s.split('-')
      if  !user.start_date.blank?  && (user.plan.no_of_emails=5)&& flag[2]>="15"
        user.emails = 3
      else
        user.emails = user.plan.no_of_emails
      end
      user.activate
      complete_signup(user)
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def complete_signup(user)
    if user.plan.fee<=0 or user.plan.fee.blank?
      if user.plan.fee == 0
        user.update_attribute("paid", true)
        self.current_user = user
        flash[:notice] = "Signup complete!"
      elsif user.plan.fee.blank? or user.plan.fee<0
        flash[:notice] = "Please contact Trusted Insight for your annual fee payment and account activation."
        self.current_user=nil
      end
    else
      unless user.paid?
        return(redirect_to new_order_url+"/"+user.id.to_s)
      else
        self.current_user = user
      end
    end
    @classified_funds=ClassifiedFund.find(:all,:conditions =>{:user_id=>user.id,:classified_fund_type=>'buy',:status=>'approved'} )
    if ((user.plan.role_id==3&& user.profile.organization_type.name=="Placement Agent" ||user.profile.organization_type.name=="Broker")||(user.plan.role_id==2 && user.plan.rank==1)) && (not current_user.has_role('Admin'))
      url = 'http://' + request.env["HTTP_HOST"]+'/users/upgrade_account/'+ user.id.to_s
      #Mailer.deliver_manager_account_upgrade_mail(user,url)  #send mail to user
      # flash[:notice] = 'A mail has been sent to your account'
    end
    if user && (((user.plan.role_id==2 && (user.profile.organization_type.name=="Asset Manager" ||user.profile.organization_type.name=="Fund of Funds" || user.profile.organization_type.name!="Fund Manager")) || (user.plan.role_id==1 && @classified_funds.blank?) || (user.plan.role_id==3 && user.profile.organization_type.name=="Consultant")) && (not current_user.has_role('Admin')))
      redirect_to :controller=>"classified_funds",:action=>"new_fund_to_buy"
    else
      redirect_to '/'
    end
  end
  
  def cancel_registration
    @user = User.find(params[:id])
    @user.destroy
    current_user=nil
    redirect_to "/"
  end

  def confirmation
    @user = User.find(params[:id])
    return (redirect_to '/') if !@user
    setup_paypal_keys
  end
  
  def edit_profile
    if params[:user_id]
      @user=User.find_by_id(params[:user_id])
    else
      @user = User.find(current_user)
    end
    @manager=nil
    @profile = @user.profile
    @messages = Message.paginate :conditions => "receiver_id = #{current_user.id} and receiver_delete_status=true", :order => 'created_at desc', :page => params[:page], :per_page => 7
    @type="inbox"
    @classified_fund_sell = ClassifiedFund.paginate(:all, :conditions => {:classified_fund_type => 'sell',  :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    @classified_fund_buy = ClassifiedFund.paginate(:all, :conditions => {:classified_fund_type => 'buy',  :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    @company_sell = Company.paginate(:all, :conditions => {:company_type => 'sell',  :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    @company_buy = Company.paginate(:all, :conditions => {:company_type => 'buy',  :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    @secondaries_sell = Secondary.paginate(:all, :conditions => {:secondary_type => 'Sell', :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    @secondaries_buy = Secondary.paginate(:all, :conditions => {:secondary_type => 'Buy', :user_id => @user.id, :status => 'approved'}, :per_page => 5, :page => 1)
    if current_user.plan.role.title.eql?('Fund Manager')
      @manager = Manager.find(@user.manager_id, :conditions => "status='approved'") if @user.manager_id
      if @manager
        @pros = AssetAttribute.find_all_attributes_by_type("pros", @manager.asset_primary_id)
        @cons = AssetAttribute.find_all_attributes_by_type("cons", @manager.asset_primary_id)
        @comments = Comment.paginate :per_page => 25, :page => params[:page], :conditions => "manager_id = #{@manager.id} and status = 'approved'", :order =>"created_at desc"
        @ratings = Rating.find_latest_rating(current_user, @manager)
      end
    end
    @answers = Answer.find(:all, :joins => 'inner join questions q on q.id = answers.question_id', :conditions => "q.status=true and user_id=#{@user.id}", :order => "q.rank asc")
    @view = 'main'                         # the variable which says which part of the page to show
  end
  
  def update_profile
    @profile = Profile.find(params[:id])
    success = @profile.update_attributes(params[:profile])
    #    err = ""
    #    @profile.errors.each{|x,y|
    #      err=err+x.humanize+": #{y}<br/>"
    #    }
    render(:update) do |page|
      if success
        flash[:notice] = 'Profile updated successfully'
        page.call :reload_profile
      else
        page.show :errors
        page.replace_html :errors, (error_messages_for :profile)
      end 
    end
  end

  def payment_received
    @tx_id = params[:tx]
    @status = params[:st]
    @user = User.find(params[:item_number])
  end
  
  def change_password
    @user = User.find(current_user.id)
    #    begin
    begin
      @user.change_password(params[:old_password], params[:new_password], params[:new_password_confirmation])
    rescue => err
      @user.errors.add_to_base(err)
    end
    render(:update) do |page|
      if @user.errors.blank?
        page.show :info_msg
        page.replace_html :info_msg, :text => "<ul><li style='list-style: disc;margin: 5px 20px;'>Password updated successfully</li></ul>"
        page.call "hide_info_msg"
      else
        page.show :err_msg
        page.replace_html :err_msg, :text => "#{error_messages_for :user}</li>"
        page.call "hide_err_msg"
      end
    end
  end
  
  def forgot_password
  end

  def forgot_password_mail
    if params[:email].blank?
      flash[:error] = 'Email cannot be blank'
    else
      reg = Regexp.new(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
      if params[:email].match(reg)
        @profile = Profile.find(:first, :conditions => {:email => params[:email]})
        if @profile.nil?
          flash[:error] = 'User with the supplied email id does not exists'
        else
          user = @profile.user
          url = 'http://' + request.env["HTTP_HOST"]+'/users/' + 'reset_password/'+ user.id.to_s
          Mailer.deliver_forgot_password(@profile, url,user.login)
          flash[:notice] = 'A mail has been sent to your account'
        end
      else
        flash[:error] = 'Please enter a valid email Id'
      end
    end
    render :action => 'forgot_password'
  end


  def reset_password
    @user = User.find_by_id(params[:id]) unless params[:id].blank?
    if @user.blank?
      flash[:error]  = "We couldn't find a user  -- check your email? Or maybe you've already activated -- try signing in."
      render :partial=>'forget_password_mail'
    else
      flash[:notice] = 'Welcome to password reset window.'
    end
  end

  def set_password
    user=User.find_by_id(params[:id])
    if params[:user][:password]==params[:user][:password_confirmation]
      user.update_password(params[:user][:password])
      user.save
      flash[:notice] = "Your password is reset , now you can login with your new password."
      redirect_to :controller => "main",:action =>"index"
    else
      redirect_to :action =>'reset_password' ,:id =>user.id
      flash[:notice] = "Your password and confirm password do not match,please re-enter again."
    end
  end

  
  def upgrade_membership
    redirect_to :controller => "orders", :action => "new", :id => current_user.id, :plan_id => params[:id], :upgrade => true
  end

  def upgrade_plan
    lc = ClassifiedFund.count(:all,:conditions=>{:status=>"approved"})
    ld = Company.count(:all,:conditions=>{:status=>"approved"})
    ls = Secondary.count(:all,:conditions=>{:status=>"approved"})
    @total_postings = lc + ld + ls
    sd=Company.total_desired_size
    ss=Secondary.total_net_asset_value
    sf=ClassifiedFund.total_desired_size
    @total_sum=ss.to_f+sd.to_f+sf.to_f
    @plan = Plan.find(params[:id]) if params[:id]

    user=current_user

    @plus = Plan.find(:first, :conditions => "role_id=#{user.plan.role_id} and name='Plus Monthly'")
    @premium = Plan.find(:first, :conditions => "role_id=#{user.plan.role_id} and name='Premium Monthly'")
    
    user.start_date=Date.today.strftime("%Y-%m-%d")
    if user.plan.duration=="14 month" 
      user.end_date=user.start_date.to_date >>(14)
    elsif user.plan.duration=="1 month"
      user.end_date=user.start_date.to_date >>(1)
    end
    user.save(false)
  end

  def upgrade_account
    @user = User.find_by_id(params[:id]) unless params[:id].blank?
    if @user
      if @user.plan.fee<=0 or @user.plan.fee.blank?
        if @user.plan.fee == 0
          @user.update_attribute("paid", true)
          self.current_user = @user
        elsif @user.plan.fee.blank? or @user.plan.fee<0
          flash[:notice] = "Please contact Trusted Insight for your annual fee payment and account activation."
          self.current_user=nil
        end
      else
        unless @user.paid?
          return(redirect_to new_order_url+"/"+@user.id.to_s)
        else
          self.current_user = @user
        end
      end
      redirect_to :action=>"upgrade_plan",:locals=>{:plan=>@user.plan,:current_user=>@user}
    end
  end

  # action for paypal instant notification
  def ipn
    if params[:product_name]
      user_information=params[:product_name].split(',')
    elsif params[:item_name]
      user_information=params[:item_name].split(',')
    end
    PaymentNotification.create(:user_id=>user_information[0],:payment_type=>user_information[2],:ipn_details=>params)
    user=User.find_by_id(user_information[0])
    order=Order.find_by_id(user_information[1])
    if user_information[2]=="company_to_sell"
      if params[:txn_type]=="web_accept" && params[:payment_status]=="Completed" 
        order.update_attributes(:transaction_id=>params[:txn_id])
        user.update_attribute('credit', user.credit + 1)
      end
    else
      unless user_information[2]=="sign_up"
        if params[:payment_status]=="Completed" && params[:txn_type]=="recurring_payment"
          user.update_attributes(:end_date=>params[:next_payment_date].to_date,:start_date=>params[:time_created].to_date)
          order.update_attributes(:transaction_id=>params[:txn_id],:status=>params[:payment_status])
          flag = user.start_date.to_s.split('-')
          if  !user.start_date.blank?  && (user.plan.no_of_emails==5)&& flag[2]>="15"
            user.emails = 3
          else
            user.emails = @user.plan.no_of_emails
          end
        else
          unless params[:payment_status]=="Pending"
            if !user.end_date.blank? && user.end_date>=Date.today
              order.update_attributes(:transaction_id=>params[:recurring_payment_id],:status=>params[:payment_status])
            else
              user.update_attribute(:paid,false)
            end
          else
            flash[:notice] = "Your Account will be upgrade in some time ."
          end
        end
      else
        if params[:payment_status]=="Completed" && params[:txn_type]=="recurring_payment"
          order.update_attributes(:transaction_id=>params[:txn_id])
          user.update_attributes(:end_date=>params[:next_payment_date].to_date,:start_date=>params[:time_created].to_date)
          flag = user.start_date.to_s.split('-')
          if  !user.start_date.blank?  && (user.plan.no_of_emails==5)&& flag[2]>="15"
            user.emails = 3
          else
            user.emails = user.plan.no_of_emails
          end
        end
      end
    end
    render :nothing => true
  end

  #  def newmailertemp
  #    @firstname='sumit'
  #    @lastname='dey'
  #    @email='sumitkrdey@gmail.com'
  #    @login='sumitdey'
  #    @password='welcome'
  #    Mailer.deliver_newmailertemp(@firstname,@lastname,@email,@login,@password)
  #  end

  def destroy
    user = User.find(params[:id])
    user.update_attribute("status","unapproved")
    flash[:notice] = "User <b>#{user.login}</b> has been deactivated."
    redirect_to :controller=>"admin", :action => "active_users"
  end

  def update_users_organization_type

  end

  def mail_after_week
    @users=User.find(:all,:conditions=>{:status=>"approved",:login=>"sick"})
    for user in @users
      if (user.plan.rank==1 && user.plan.role.id!=3) ||(user.profile.organization_type.name=="Placement Agent" && user.plan.name=="Basic")
        url = 'http://' + request.env["HTTP_HOST"]+'/users/' + 'upgrade_plan/'
        #Mailer.deliver_manager_account_upgrade_mail(user,url)
      end
    end
    redirect_to :controller=>"admin", :action => "index"
    # flash[:notice] = "Mail has been sent."
  end

  private
  def setup_paypal_keys
    @business_key = File::read(File.dirname(__FILE__) + "/../../config/paypal/private_key.pem")
    @business_cert = File::read(File.dirname(__FILE__) + "/../../config/paypal/public_cert.pem")
    @business_certid = APP_CONFIG['business_certid']
    @business_email = APP_CONFIG['business_email']
    Paypal::Notification.ipn_url = APP_CONFIG['paypal_url']
    Paypal::Notification.paypal_cert = File::read(File.dirname(__FILE__) + "/../../config/paypal/" + APP_CONFIG['paypal_cert_file'])
  end
end
