class SecondariesController < ApplicationController
  uses_tiny_mce(:options => {:theme => 'advanced',
      :browsers => %w{msie gecko},
      :theme_advanced_toolbar_location => "top",
      :theme_advanced_toolbar_align => "left",
      :theme_advanced_resizing => true,
      :theme_advanced_resize_horizontal => false,
      :paste_auto_cleanup_on_paste => true,
      :theme_advanced_resizing => true,
      :theme_advanced_buttons1 => "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
      :theme_advanced_buttons2 => "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
      :theme_advanced_buttons3 => "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
      :plugins => %w{safari spellchecker pagebreak style layer table save advhr advimage advlink emotions iespell inlinepopups insertdatetime preview media searchreplace print contextmenu paste directionality fullscreen noneditable visualchars nonbreaking xhtmlxtras template imagemanager filemanager}})

  before_filter :login_required
  layout :secondary_layout
  after_filter :store_location, :only => [:index, :new, :show, :edit]
  access_control [:delete_postings] => 'admin'

  def secondary_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end


  # GET /secondaries/1
  def show
    @message = Message.new(:manager_id => params[:id], :sender_id => current_user.id);
    @secondary = Secondary.find(params[:id])
    if @secondary
      unless UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'View', :regarding_type => 'secondary', :regarding_id => @secondary.id})
        current_user.update_attribute("views", current_user.views - 1)
        UserActivity.create({:user_id => current_user.id, :activity => 'View', :regarding_type => 'secondary', :regarding_id => @secondary.id})
      end
      if !@secondary.manager.blank?
        @manager = @secondary.manager
        @pros = AssetAttribute.find_all_attributes_by_type("pros", @manager.asset_primary_id)
        @cons = AssetAttribute.find_all_attributes_by_type("cons", @manager.asset_primary_id)
        @comments = Comment.paginate :per_page => 25, :page => params[:page], :conditions => "manager_id = #{@manager.id} and status = 'approved'", :order =>"created_at desc"
        @ratings = Rating.find_latest_rating(current_user, @manager)
      end
    end
  end

  # GET /secondaries/new
  def new
    @managers = Manager.find(:all, :conditions => "status = 'approved'")
    @secondary = Secondary.new
    if params[:manager_id]
      @secondary.manager_id=params[:manager_id].to_i
    end
    @secondary.secondary_type = params[:id]
    if @secondary.secondary_type == 'buy' # or @secondary.secondary_type = 'sell'
      render :action => "upload_buy"
    elsif @secondary.secondary_type == 'sell'
      render :action => "upload_sell"
    else
      if current_user.has_role('Admin') then redirect_to :controller => "admin", :action => "index" else redirect_to :controller => "main", :action => "index" end
    end
  end

  # GET /secondaries/1/edit
  def edit
    @managers = Manager.find(:all, :conditions => "status = 'approved'")
    @secondary = Secondary.find(params[:id])
    if @secondary.type_buy
      render :action => "upload_buy"
    elsif @secondary.type_sell
      render :action => "upload_sell"
    end
  end

  # POST /secondaries
  def create
    @secondary = Secondary.new(params[:secondary])
    @secondary.user_id = current_user.id
    @secondary.creator = current_user
    if current_user.has_role('Admin')
      if params[:secondary][:user_login].blank?
        @secondary.admined = true
      else
        @secondary.admined = false
      end
      @user = User.find_by_login(params[:secondary][:user_login])
      if  @user.blank? || @user.id==1
        flash[:notice] = 'Not a valid User Name choose a user from dropdown'
        render :action => "upload_buy"
      else
        @secondary.user_id=@user.id
        if @secondary.save
          flash[:notice] = 'Secondary was successfully created.'
          if @secondary.type_sell
            redirect_to :action => "index", :type=> @secondary.secondary_type
          end
          if @secondary.type_buy
            redirect_to :action => "index", :type=> @secondary.secondary_type
          end
        end
      end
    else
      if @secondary.save
        if (params[:secondary][:description].gsub( /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/,''))
          if @secondary.type_sell
            Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"Secondary to sell")
          else
            Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"Secondary to buy")
          end
        end

        flash[:notice] = 'Secondary was successfully created.'
        if @secondary.type_sell
          redirect_to :action => "index", :type=> @secondary.secondary_type
        end
        if @secondary.type_buy
          redirect_to :action => "index", :type=> @secondary.secondary_type
        end
      else
        @managers = Manager.find(:all, :conditions => "status = 'approved'")
        if @secondary.type_sell
          render :action => "upload_sell"
        end
        if @secondary.type_buy
          render :action => "upload_buy"
        end
      end
    end
  end

  def profile_secondary_list
    if current_user.has_role('Admin')
      user_id=params[:user_id]
    else
      user_id=current_user.id
    end
    if params[:type]=="buy"
      @secondaries_buy=Secondary.profile_results(params[:page],user_id,params[:type])
    else
      @secondaries_sell=Secondary.profile_results(params[:page],user_id,params[:type])
    end
    render(:update) do |page|
      if params[:type]=="buy"
        page.replace_html 'secBuy', :partial => 'profile_results', :locals => {:secondaries => @secondaries_buy,:from_edit_profile => false,:type => "buy"}
      else
        page.replace_html 'secSell', :partial => 'profile_results', :locals => {:secondaries => @secondaries_sell,:from_edit_profile => false,:type => "sell" }
      end
    end
  end




  def index_results
    if params[:search_name].blank?
      @srch = nil
      @search_name = nil
    else
      @srch=SavedSearch.find(params[:search_name])
      if @srch
        params[:search]=@srch.query
        @search_name = @srch.id
      end
    end
    
    @browseby = params[:search][:browse_by].blank? ? 'recent' : params[:search][:browse_by]
    @asset = params[:search][:asset].blank? ? 'Any' : params[:search][:asset]
    @geography = params[:search][:geography].blank? ? 'Any' : params[:search][:geography]
    @type = params[:search][:type].blank? ? 'buy' : params[:search][:type]
    @nav = params[:search][:nav].blank? ? 'Any Size' : params[:search][:nav]
    @expected_price = params[:search][:expected_price].blank? ? 'Any' : params[:search][:expected_price]
    @drawn = params[:search][:drawn].blank? ? 'Any' : params[:search][:drawn]

    @orderby = params[:order_by].blank? ? nil : params[:order_by]
    if params[:ascdesc] and params[:ascdesc].eql?'desc'
      @ascdesc = 'asc'
    else
      @ascdesc = 'desc'
    end
    
    @save_search = true if !params[:page] && !@srch

    @secondaries, @total, @amount_total = Secondary.paginate_results( params[:search], params[:order_by], params[:ascdesc], params[:page])
    @heading=Secondary.getheading(params[:search], @browseby)
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'secondariesDivBuyer', :partial => 'results', :locals => { :type => 'buy'}
#        page.replace_html 'filterDiv', :partial => 'filter'
#        page.replace_html 'header', @heading
#        if  current_user.has_role('Admin')
#          page.replace_html 'admin_breadcrumb', :partial => 'layouts/breadcrumbs'
#        else
#          page.replace_html 'breadCrumbs', :partial => 'layouts/breadcrumbs'
#        end
      end
    else
      render :action => 'index'
    end
  end

  def save_search
    success=SavedSearch.save_search(params[:search], session[:user_id], 'secondary', params[:id])
    @saved_searches = SavedSearch.find(:all, :conditions => ["user_id = ? AND search_type = 'secondary'", session[:user_id]])
    render(:update) do |page|
      if success.id.nil?
        page.replace_html 'error_div' ,"This name has already been taken.Please use a different name."
      else
        page[:saveSearch].hide
        page[:search_name].value = ''
        page[:savedSearches].show if @saved_searches.size == 1
        page.replace_html 'savedSearches', :partial => 'saved_searches', :locals => {:saved_searches => @saved_searches}
      end
    end
  end
  
  # PUT /secondaries/1
  def update
    @secondary = Secondary.find(params[:id])
    if has_access?(@secondary)
      if @secondary.update_attributes(params[:secondary])
        flash[:notice] = 'Secondary was successfully updated.'
        #redirect_to :action => 'show', :id => @secondary.id
        redirect_to :action =>'show',:id =>@secondary.id
      else
        render :action => "edit"
      end
    else
      render :text => "Sorry! You don't have enough privilege.", :layout => "secondaries_layout"
    end
  end

  # DELETE /secondaries/1
  def destroy
    @secondary = Secondary.find(params[:id])
    if has_access?(@secondary)
      @secondary.update_attributes(:status => 'deleted', :updated_at => Date.today, :updated_by => current_user.id)
      if params[:id]
        flash[:notice] = 'Secondary deleted successfully.'
        #redirect_to(secondary_url)
        redirect_to :controller => "secondaries", :action => "index",:type=>@secondary.secondary_type
      else
        render :text => "Sorry! You don't have enough privilege.", :layout => "main"
      end
    end
  end

  def get_manager_url
    if params[:manager_id]
      manager = Manager.find_by_id(params[:manager_id].gsub(/!!and!!/, '&'))
      if manager
        render :text => "<a href='http://#{manager.url}' target='_blank'>http://"+manager.url+"</a>"
      else
        render :text => "<input disabled='disabled'/>"
      end
    else
      render :text => "<input disabled='disabled'/>"
    end
  end

  def getfunds
    if params[:manager_id]
      manager = Manager.find_by_id(params[:manager_id].gsub(/!!and!!/, '&'))
    end
    if manager
      render :partial => "funds", :locals => {:manager => manager.id, :secondary => params[:secondary_id].to_i}
    else
      render :text => "<select></select>"
    end
  end

  def index
    @drawn = @expected_price = @asset = @geography = 'Any'
    @nav = 'Any Size'
    @browseby = 'recent'
    @type = params[:type].blank? ? 'buy' : params[:type]
    
    @secondaries, @total, @amount_total = Secondary.paginate_results( params )
    @heading=Secondary.getheading(params, @browseby)
  end

  def listing
    query = ""
    if !params[:manager_id].blank?
      query= " select * from secondaries where manager_id in (#{ params[:manager_id]}) and secondary_type='#{params[:type]}' and status ='approved' order by created_at desc  "
    else
      query=" select * from secondaries where user_id = '#{current_user.id}'  and secondary_type='#{params[:type]}' and status ='deleted' order by created_at desc  "
    end
    @secondaries = Secondary.paginate_by_sql( query,{:page => params[:page], :per_page => 20})
  end


  def approve_secondary
    secondary = Secondary.find(params[:id])
    if secondary
      secondary.update_attributes(:status => 'deleted', :approved_at => Date.today, :approver_id => current_user.id)
    end
    flash[:notice] = 'Secondary Approved Successfully.'
    redirect_to :action => "index"
  end

  def delete
    @secondary = Secondary.find(params[:id])
    if has_access?(@secondary)
      @secondary.update_attributes(:status => 'deleted', :updated_at => Date.today, :updated_by => current_user.id)
      if params[:id]
        flash[:notice] = 'Secondary deleted successfully.'
        redirect_to :controller => "secondaries", :action => "listing",:type=>@secondary.secondary_type
      else
        render :text => "Sorry! You don't have enough privilege.", :layout => "main"
      end
    end
  end

  def secondary_mail
    @secondary = Secondary.find(params[:id])
    if @secondary and (current_user.emails != 0) and !UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'Email', :regarding_type => 'user', :regarding_id => @secondary.user.id})
      if current_user.emails != -1
        current_user.update_attribute("emails", current_user.emails - 1)                    #Update user's data.
      end
      UserActivity.create({:user_id => current_user.id, :activity => 'Email', :regarding_type => 'user', :regarding_id => @secondary.user.id})
    end
    render :nothing => true
  end

  def delete_postings
    puts 'he hehe he hehe h'
    posts=Secondary.find(:all,:conditions =>{:user_id => params[:user_id]})
    unless posts.blank?
      posts.each do |post|
        post.update_attribute('status', 'deleted')
      end
      flash[:notice]="Your postings have been deleted."
    else
      flash[:notice]="You do not have any postings to delete. "
    end
#    redirect_to :controller => :user, :action => 'edit_profile', :user_id => params[:id]
    redirect_back_or_default("/")
  end
end
