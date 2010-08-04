class MessagesController < ApplicationController
  uses_tiny_mce(:options => {:theme => 'advanced',
      :browsers => %w{msie gecko},
      :theme_advanced_toolbar_location => "top",
      :theme_advanced_toolbar_align => "center",
      :theme_advanced_buttons1 => "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
      :theme_advanced_buttons2 => "",
      :theme_advanced_buttons3 => "",
    })

  
  before_filter :login_required,:except=>[:not_interested]
  after_filter :store_location, :only => [:index, :new, :show, :edit, :list, :destroy]
  #access_control [:list, :destroy] => 'admin'

  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  def inbox_messages
    @type="inbox"
    render :update do |page|
      @messages = Message.paginate :conditions =>{:receiver_id=>current_user.id,:receiver_delete_status=>true}, :order => 'created_at desc', :page => params[:page], :per_page => 7
      page << "document.getElementById('inbox_link').className='selected'"
      page << "document.getElementById('sent_link').className=''"
     
      page.replace_html :all_messages, :partial => "users/inbox_index", :locals=>{:messages => @messages}
    end
  end

  def sent_messages
    @type="sent"
    render :update do |page|
      @messages = Message.paginate :conditions => {:sender_id=>current_user.id,:sender_delete_status=>true}, :order => 'created_at desc', :page => params[:page], :per_page => 7
      page << "document.getElementById('inbox_link').className=''"
      page << "document.getElementById('sent_link').className='selected'"

      page.replace_html :all_messages, :partial => "users/inbox_index", :locals=>{:messages => @messages}
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    manager_id=nil
    if params[:secondary_id]
      @object = Secondary.find(params[:secondary_id])
      subject = APP_CONFIG["SUBJECT"].gsub(/!!manager_and_fund!!/, "#{@object.manager.name} - #{@object.fund.name}")
      @user = @object.user
      @post_type="secondary"
      @post_id=params[:secondary_id]
      if @object.manager
        manager_id=@object.manager.id
      end
    elsif params[:classified_fund_id]
      @object = ClassifiedFund.find(params[:classified_fund_id])
      subject = APP_CONFIG["CLASSIFIED_FUNDS_BUY_SUBJECT"]
      @user = @object.user
      @post_type="postings"
      @post_id=params[:classified_fund_id]
      if @object.manager
        manager_id=@object.manager.id
      end
    elsif params[:company_id]
      @object = Company.find(params[:company_id])
      subject = APP_CONFIG["SUBJECT_COMPANY"]
      @user = @object.user
      @post_type="company"
      @post_id=params[:company_id]
    else
      @object = Fund.find(params[:fund_id])
      subject = APP_CONFIG["CLASSIFIED_FUNDS_SELL_SUBJECT"]
      @user = @object.user
      @post_type="funds"
      @post_id=params[:fund_id]
      if @object.manager
        manager_id=@object.manager.id
      end
    end
    
    mail_body = APP_CONFIG["BODY"].gsub(/!!user_name!!/, "#{@object.user.profile.firstname} #{@object.user.profile.lastname}")
    @message = Message.new(:subject => subject, :body => "Hello,\n\nWe are interested in discussing your position listed on Trusted Insight. Our contact info is below. [We suggest that you tell the other party a little about your organization or institution that you are representing].\n\nSincerely", :sender_id => current_user.id, :manager_id =>manager_id,:post_type=>@post_type,:post_id=>@post_id)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  def not_interested
    @message=Message.find_by_id(params[:id])
#    sender_email=User.find_by_id( @message.receiver_id).profile.email
    receiver_email=User.find_by_id( @message.sender_id).profile.email
    desc=@message.automatic_description_for_all_types(@message.post_type,@message.post_id)
    if @message.is_not_interested==false
      @message.is_not_interested=1
      @message.save
      Mailer.deliver_response_mail(receiver_email,@message,desc)
      render  :nothing => true, :text => "You have replied that you do not have interest in his #{@message.post_type}.",:layout =>"main"
    else
      render  :nothing => true
    end
  end

  def interested_in_reply
    @message=Message.find_by_id(params[:id])
    sender_email=User.find_by_id( @message.sender_id).profile.email
    desc=@message.automatic_description_for_all_types(@message.post_type,@message.post_id)
    if @message.is_interested==false
      @message.is_interested=1
      @message.save
      Mailer.deliver_interested_reply_to_mail(sender_email,@message,desc)
      render  :nothing => true, :text => "You have replied that you have interest in his #{@message.post_type}.",:layout =>"main"
    else
      render  :nothing => true
    end
  end

  def search_string
    @messages=Message.find(:all)
    messg=[]
    for msg in @messages
      if msg.subject.match(params[:value])||msg.body.match(params[:value])||msg.sender.fullname.match(params[:value])
        messg << msg
      end
    end
    render :update do |page|
      page.replace_html "all_messages", :partial=>'users/inbox_index', :locals => {:messages => messg}
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    if(params[:touserid])
      @touser =User.find_by_id(params[:touserid])
      @toprofile=@touser.profile
      @message.receiver_id=(params[:touserid])
      @message.receiver_delete_status=true
      @message.sender_delete_status=true
      respond_to do |format|
        if @message.save
          url_not_interested = 'http://' + request.env["HTTP_HOST"]+'/messages' +'/not_interested/'+@message.id.to_s
          url_reply_to = 'http://' + request.env["HTTP_HOST"]+'/messages' +'/interested_in_reply/'+@message.id.to_s
          Mailer.deliver_contact_mail(@message, current_user,@toprofile,url_not_interested,url_reply_to)
          flash[:notice] = 'Message was successfully sent.'
          user=User.find(current_user.id)
          user.update_attribute("emails", user.emails-1)
          format.html { render :action => "done"}
          format.xml  { render :xml => @message, :status => :created, :location => @message }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    @messages_sent=Message.find(:all,:conditions=>{:sender_id=>current_user.id})
    @messages_received=Message.find(:all,:conditions=>{:receiver_id=>current_user.id})
    redirect_to :controller=>"users",:action=>"edit_profile"
  end


end
