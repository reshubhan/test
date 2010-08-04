class NotificationsController < ApplicationController
  access_control [:index, :show, :new, :update, :create, :delete, :edit, :send_now] => 'admin'
  uses_tiny_mce :options => {
    :theme => 'advanced',
    :theme_advanced_resizing => true,
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_toolbar_align => "left",
    :theme_advanced_statusbar_location => "bottom",
    :plugins => %w{ table fullscreen },
    :elements => "body"
  }
  auto_complete_for :notification, :name
  before_filter :login_required
  layout 'admin'


  # GET /notifications
  # GET /notifications.xml
  
  def index
    params[:page] ||= 1
    @notifications = Notification.paginate :per_page => 25, :page => params[:page],:order => 'created_at desc'

    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "notification_list"
      end
    end
  end

  # GET /notifications/1
  # GET /notifications/1.xml
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.xml
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.xml
  def create
    # render :text => params.inspect
    @notification = Notification.new(params[:notification])
    unless params[:plans].blank?
      plans = Plan.find(params[:plans])
      @notification.plans = plans
      if @notification.save
        flash[:notice] = 'Notification was successfully created.'
        redirect_to('/notifications')
      else
        render :action => "new"
      end
    else
      @notification.errors.add_to_base("Please select the user Plans.")
      render :action => "new"
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.xml
  def update
    @notification = Notification.find(params[:id])
    unless params[:plans].blank?
      plans = Plan.find(params[:plans])
      @notification.plans = plans
    end
    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        flash[:notice] = 'Notification was successfully updated.'
        format.html { redirect_to('/notifications') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.xml
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to(notifications_url) }
      format.xml  { head :ok }
    end
  end

  def send_now
    puts "Sending ...."
    users = []
    current_notifications = []
    to_day = Date.today
    notifications = Notification.find(:all, :conditions => "id=#{params[:id]}")
    notifications.each do |notification|
      if(notification.mailer_type.name=="daily" )
        current_notifications << notification
      elsif (notification.mailer_type.name=="weekly")
        if notification.iteration== to_day.wday
          current_notifications << notification
        end
      elsif (notification.mailer_type.name=="monthly")
        if notification.iteration== to_day.mday
          current_notifications << notification
        end
      end
    end
    current_notifications.each { |notice|
      notice.plans.each { |plan|
        users = users+User.find(:all, :conditions=>"plan_id=#{plan.id} and status='approved'")
      }
      users.each { |user|
        Mailer.deliver_notice(user,notice.subject,notice.body)
        puts "#{notice.subject} Email alert has been prepared to send on #{to_day} to #{user.profile.email}"
      }
      users.clear
    }
    render :nothing => true
  end

  def show_frequency
    @frequency = nil
    case params[:id]
      when '1'
        @frequency = 'daily'
      when '2'
        @frequency = 'weekly'
      when '3'
        @frequency = 'monthly'
    end
    render :partial => 'frequency'
  end

  def toggle_body
    render :partial => 'body_notification', :locals => { :type => params[:id] }
  end

  def change_status
    @notification = Notification.find(params[:id])
    @notification.update_attribute('status', ((@notification.status)? false : true))
    render :partial => 'status_links', :locals => { :status => @notification.status, :id => @notification.id }
  end
end

