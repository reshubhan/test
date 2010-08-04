class ManagersController < ApplicationController
  auto_complete_for :manager, :name, :limit => 15
  before_filter :login_required, :except => [:new, :create, :check_availibility, :reminder]
  layout :managerslayout

  after_filter :store_location, :only => [:index, :new, :show, :edit, :list, :destroy]
  access_control [:deleted_managers] => 'admin'
  
  def managerslayout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  
  # GET /managers
  # GET /managers.js
  def index
    @geography='All'
    @asset='All'
    @browseby='popular'
    @sector='All'
    @time='All'
    @sizemin='0'
    @sizemax=Fund.max_size_for_scroller
    @open=false
    @featured_managers=[]
    mgrs=Manager.find(:all,:conditions =>{:featured => true,:status =>"approved"},:select =>"id")
    mgrs.each do |value|
      @featured_managers << value.id
    end
    if params[:search]
      @managers = Manager.find(:all, :conditions => ["name LIKE ? and status = 'approved' ", "#{params[:search]}%"])
    else
      @managers = Manager.manager_results(10, 1, params)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :layout => false }
    end
  end

  def image_create
    @manager = Manager.create( params[:manager] )
  end

  
  def search
    @manager = nil;
    unless params[:manager][:name].blank?
      if params[:manager][:name].downcase=='search manager'
        redirect_to(:back)
      else
        @manager = Manager.find(params[:manager][:name])
        unless @manager.blank?
          redirect_to :action => 'show', :id => @manager.id
        else
          flash[:error] = 'Manager with specified name does not exists.'
          redirect_to(:back)
        end
      end
    else
      @manager = Manager.find(:all)
      flash[:notice] = 'Please select a manager to view the details.'
      redirect_to :action => 'index'
    end
  end

 
  
  def filter_results
    @browseby = params[:browseby].blank? ? 'popular' : params[:browseby]
    @geography = params[:geography].blank? ? 'All' : params[:geography]
    @asset = params[:asset].blank? ? 'All' : params[:asset]
    @time = params[:time].blank? ? 'All' : params[:time]
    @sizemin = params[:size_min].blank? ? '0' : params[:size_min].to_i
    @sizemax = params[:size_max].blank? ? Fund.max_size_for_scroller : params[:size_max].to_i
    @sector = params[:sector].blank? ? 'All' : params[:sector]
    @size = params[:size_max]
    if params[:open] and params[:open]=='true'
      @open = params[:open]
    else
      @open = false
    end
    if params[:seller] and params[:seller]=='true'
      @seller = params[:seller]
    else
      @seller = false
    end
    if params[:buyer] and params[:buyer]=='true'
      @buyer = params[:buyer]
    else
      @buyer = false
    end
    @managers = Manager.manager_results(10, params[:page], params)
    if @asset=="All"
      @featured_managers=[]
      mgrs=Manager.find(:all,:conditions =>{:featured => true,:status =>"approved"},:select =>"id")
      mgrs.each do |value|
        @featured_managers << value.id
      end
    else
      sponsered_managers_for_asset= Asset.find_by_id(@asset).sponsered
      unless sponsered_managers_for_asset.nil?
        @featured_managers= sponsered_managers_for_asset.split(',').compact.collect{|x| x.to_i}
        if Asset.find(@asset).parent_id
          mgrs=Manager.find(:all,:conditions =>{:asset_secondary_id => @asset,:status =>"approved"})
        else
          mgrs=Manager.find(:all,:conditions =>{:asset_primary_id => @asset,:status =>"approved"})
        end
        if mgrs
          mgrs.each do |mangr|
            mangr.update_attribute(:featured, false)
          end
        else
          
        end
        @featured_managers.each  do |manager_id|
          Manager.find(manager_id).update_attribute(:featured, true)
        end
      end
    end
    
    render(:update) do |page|
      if  params['browseby'].eql?'recent'
        page.replace_html 'header', "Recently Added Funds"
      elsif params['browseby'].eql?'rated'
        page.replace_html 'header', "Highest Rated Funds"
      else 
        page.replace_html 'header', "Most Popular Funds"
      end 
      page.replace_html 'filterDiv', :partial => 'filter'
      page.replace_html 'managersDiv', :partial => 'manager'
      if (not current_user.has_role('Admin'))
        if params[:asset] && params[:asset]!='All'&& (Asset.find_by_id(@asset)).adverts.size>0 && (params[:page].nil? or params[:page]=='1')
          html=""
          (Asset.find_by_id(@asset)).adverts.each do |advert|
            html << "<a target='_blank' href='#{advert.link}'><img style='height:140px;width:140px;' src='#{advert.public_filename(:medium)}'/></a><br/><br/>"
          end
          page.show 'asset_ad'
          page.replace_html 'asset_ad', html
        else
          page.hide "asset_ad"
        end
        if params[:geography] && params[:geography]!='All'&&(Geography.find_by_id(@geography)).adverts.size>0 && (params[:page].nil? or params[:page]=='1')
          html = ""
          (Geography.find_by_id(@geography)).adverts.each do |advert|
            html << "<a target='_blank' href='#{advert.link}'><img style='height:140px;width:140px;' src='#{advert.public_filename(:medium)}'/></a><br/><br/>"
          end
          page.show 'geography_ad'
          page.replace_html 'geography_ad', html
        else
          page.hide "geography_ad"
        end
      end
    end
  end
  
  # GET /managers/1
  def show
    @manager = Manager.find(params[:id], :conditions => "status='approved'")
    if @manager
      @pros = AssetAttribute.find_all_attributes_by_type("pros", @manager.asset_primary_id)
      @cons = AssetAttribute.find_all_attributes_by_type("cons", @manager.asset_primary_id)
      @comments = Comment.paginate :per_page => 25, :page => params[:page], :conditions => "manager_id = #{@manager.id} and status = 'approved'", :order =>"created_at desc"
      #      @ratings = Rating.find_latest_rating(current_user, @manager)
      if request.xhr?
        render(:update) do |page|
          page.replace_html 'results', :partial => "comments"
        end
      else
        unless UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'View', :regarding_type => 'fund', :regarding_id => @manager.id})
          current_user.update_attribute("views", current_user.views - 1)
          UserActivity.create(:user_id => current_user.id, :activity => 'View', :regarding_type => 'fund', :regarding_id => @manager.id)
        end
      end
    else
      if request.xhr?
        render(:update) do |page|
          page.replace_html 'results', :text => "This manager is not available."
        end
      end
    end
  end

  # GET /managers/new
  def new
    @flow_check = params[:id]
    if (params[:plan] && params[:role])
      @plan = params[:plan]
      @role = params[:role]
    end
    @manager = Manager.new
  end
  # GET /managers/1/edit
  def edit
    @manager = Manager.find(params[:id])
    if @manager.status == "deleted"
      render :text => "Sorry!! The manager have been deleted earlier by the owner. Please contact Trusted Insight."
    end
  end

  # POST /managers
  def create
    expire_fragment(:key => "search")
    @manager = Manager.new(params[:manager])
    #    if !session[:money_manager_id].blank?
    #      @user = User.find(session[:money_manager_id])
    #      @manager.creator = @user
    #      @manager.updater = @user
    #      @manager.user_id = @user
    #    else
    @plan=params[:plan] unless @plan
    @role=params[:role] unless @role
    unless current_user
      admin = User.find_by_login('admin') # Admin
      @manager.creator = admin
      @manager.updater = admin
      @manager.user_id = admin
      if params[:featured]
        @manager.featured=true
      else
        @manager.featured=false
      end
    else
      @manager.creator = current_user
      @manager.updater = current_user
      if current_user
        if current_user.has_role('Admin')
          @manager.admined = true
          @user = User.find_by_login(params[:manager][:user_login])
          if @user
            @manager.user_id=@user.id
          end
        else
          @manager.user_id=current_user.id
        end
      else
        flash[:notice] = "Oops!! It seems you forgot to login. Please login and try again."
        return (redirect_to '/')
      end
    end
    #    end
    
    @manager.image_url = APP_CONFIG["WEBSNAPR_URL"] + @manager.url
    if @manager.save
      #      if !session[:money_manager_id].blank?
      #        @user.manager_id = @manager.id
      #        @user.save
      #        if @user.plan.fee == 0
      #          url = 'http://' + request.env["HTTP_HOST"]+'/activate/' + @user.activation_code
      #          Mailer.deliver_account_activation_mail(@user, url)
      #          flash[:notice] = 'Your signup is now complete. A mail has been sent to your account.'
      #          logout_keeping_session!
      #        else
      #          flash[:notice] = 'Your signup is now complete.Please login to your account to access it.'
      #        end
      #        session[:money_manager_id] = nil
      #        redirect_to '/'
      #      else
      unless current_user
        flash[:notice] = 'Manager was successfully created. You can now continue with creating your Money Manager account.'
        redirect_to :controller => "users", :action => "new", :plan => params[:plan], :role => params[:role], :manager_id => @manager.id
      else
        flash[:notice] = 'Manager was successfully created.'

        if params[:continue]
          redirect_to :controller => "funds", :action => "new", :id => @manager.id
        elsif params[:flow] == 'funds'
          redirect_to :controller => "classified_funds", :action => "new", :id => "sell", :manager_id => @manager.id
        else
          redirect_to :managers
        end
      end
      #      end
    else
      render :action => "new"
    end
  end

  # PUT /managers/1
  def update
    expire_fragment(:key => "search")
    if (params[:action]=='update')&& (params[:manager][:name].blank?||params[:manager][:url].blank?)
      flash[:notice] = 'Url or Name cannot be empty'
      redirect_to :action =>"edit" and return
    end
    @manager = Manager.find(params[:id])
    if  !current_user.has_role('Admin') && (@manager.name != params[:manager][:name])
      @manager.new_name = params[:manager][:name]
      params[:manager][:name]=@manager.name
    end
    if  !current_user.has_role('Admin') && (@manager.url != params[:manager][:url])
      @manager.new_url = params[:manager][:url]
      params[:manager][:url]=@manager.url
    end
    @manager.updater = current_user
    @manager.image_url =  APP_CONFIG["WEBSNAPR_URL"] + @manager.url
    if params[:featured]
      @manager.featured=true
    else
      @manager.featured=false
    end
    if @manager.update_attributes(params[:manager])
      if current_user.has_role('Admin')
        flash[:notice] = 'Manager was successfully updated'
      else
        flash[:notice] = 'Manager was successfully updated. The changes made to name and URL are pending admin approval'
      end
      if params[:continue]
        redirect_to :controller => "funds", :action => "new", :id => @manager.id
      else
        redirect_to :managers
      end
    else
      render :action => "edit"
    end
  end

  # DELETE /managers/1
  def destroy
    expire_fragment(:key => "search")
    @manager = Manager.find(params[:id])
    if has_access?(@manager)
      @manager.status = "deleted"
      @manager.approved_at = Date.today
      @manager.approver_id = current_user
      @manager.save
      if @manager.funds
        @manager.funds.each do |fund|
          fund.update_attributes(:approved_at => Date.today, :approver_id => current_user.id, :status => "deleted")
        end
      end
      if @manager.secondaries
        @manager.secondaries.each do |secondary|
          secondary.update_attributes(:approved_at => Date.today, :approver_id => current_user.id, :status => "deleted")
        end
      end
      redirect_to(managers_url)
    else
      render :text => "Sorry! You don't have enough privilege.", :layout => "managers_layout"
    end
  end
  
  def review_manager
    if !(params[:id].blank?)
      begin
        Manager.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Manager with supplied id does not exist"
        redirect_to :managers
      else
        @id = params[:id]
        @pros = AssetAttribute.find_all_attributes_by_type("pros", @id)
        @cons = AssetAttribute.find_all_attributes_by_type("cons", @id)
      end
    else
      redirect_to :managers
    end
  end

  def save_ratings
    review_saved=false
    @manager = Manager.find(params[:id])
    #    old_votes = AssetAttributeManager.find(:all, :conditions => "manager_id = #{@manager.id.to_s} and user_id = #{current_user.id.to_s}")
    #    old_votes.each { |old_vote| old_vote.destroy } if old_votes and old_votes.size>0
    countp=countc=0
    if !params[:asset_attributes].blank?
      params[:asset_attributes].split(',').each{
        |attrib| @asset_attribute=AssetAttribute.find(attrib.to_i)
        @asset_attribute.attribute_type=="pros"?countp +=1 : countc +=1
      }
      if countp < 3 or countc < 3 or params[:rating_performance].eql?('0') or params[:rating_team].eql?('0') or params[:rating_terms].eql?('0') or params[:rating_strategy].eql?('0') or params[:rating_overall].eql?('0')
        flash[:error] = "You have to select 3 pros and 3 cons and rate against all categories"
      else
        review_saved=true
        hash = Hash.new(0)
        params[:asset_attributes].split(',').each { |attrib|
          if (hash.has_key?(attrib))
            hash[attrib] += 1
          else
            hash[attrib] = 1
          end
        }
        hash.each { |key, value|
          @manager_attribute=AssetAttributeManager.create(:asset_attribute_id => key, :manager_id => @manager.id, :user_id => 1, :votes=>value) }

        @rating=Rating.find(:first, :conditions => "manager_id = #{params[:id]} and user_id = #{current_user.id}")
        #        if @rating
        #          @rating.update_attributes(:performance => params[:rating_performance],
        #            :team =>params[:rating_team],
        #            :terms => params[:rating_terms],
        #            :strategy => params[:rating_strategy],
        #            :overall => params[:rating_overall])
        #        else
        @rating=Rating.create(:performance => params[:rating_performance],
          :team =>params[:rating_team],
          :terms => params[:rating_terms],
          :strategy => params[:rating_strategy],
          :overall => params[:rating_overall],
          :manager_id=>params[:id],
          :user_id => 1)
        #        end
      end
    end
    if(review_saved)
      flash[:notice] = "Details saved successfully"
    else
      flash[:error] = "Manager has not been rated, Please rate this manager."
    end
    redirect_to params[:from]
  end

  def save_comment
    if !params[:comment].blank? && !params[:comment][:body].blank?
      if !(params[:comment][:experience_level] or params[:comment][:relationship])
        @user_id = current_user.id
      else
        @user_id = params[:comment][:user_id]
      end
      if (params[:comment][:body].length > 2000)
        flash[:error] ="Maximum of 2000 characters allowed for comment"
      else
        if (current_user.manager_id == params[:id]) && (current_user.replies == 0)
          flash[:notice] = "You don't have any more replies left.Please upgrade."
          return redirect_back_or_default('/')
        end
        @comment=Comment.create(:body => params[:comment][:body],:manager_id => params[:id],
          :user_id => @user_id, :relationship => params[:comment][:relationship],
          :experience_level => params[:comment][:experience_level], :parent_id => params[:parent_id],
          :title => params[:comment][:title])
        flash[:notice] ="Comment saved successfully"
        if @comment && Manager.find(params[:id]).belongs_to_user(current_user)
          current_user.update_attribute("replies", current_user.replies - 1)
          UserActivity.create({:user_id => current_user.id, :activity => 'Reply', :regarding_type => 'reply', :regarding_id => params[:id]})
        end
      end
    else
      flash[:error] ="Comment cannot be blank"
    end
    flash[:openReviewTab] = "true"
    redirect_to :action => 'show', :id => params[:id]
  end

  # manager_id is hard coded because it has to be link by other page for manager_id
  def manager_report
    @funds = Fund.find(:all , :conditions => {:manager_id => 2})
    @performance=(Rating.average(:performance, :conditions => {:manager_id => 2})).to_i
    @terms=(Rating.average(:terms, :conditions => {:manager_id => 2})).to_i
    @team=(Rating.average(:team, :conditions => {:manager_id => 2})).to_i
    @strategy =(Rating.average(:strategy, :conditions => {:manager_id => 2})).to_i
    @overall =(Rating.average(:overall, :conditions => {:manager_id => 2})).to_i
    @manager = Manager.find(2)
    @comments = Comment.paginate :page => params[:page], :conditions => "manager_id = #{@manager.id} and status = 'approved'"
    @total_comments = Comment.count(:manager_id, :conditions => {:manager_id => 2})
  end

  def list
    @managers = Manager.paginate :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results", :layout => 'admin'
      end
    end
  end

  def check_availibility
    manager = Manager.find(:first, :conditions => "name = '#{params[:manager_name]}'")
    if !manager.blank?
      user = User.find_all_by_manager_id(manager.id)
      if !user.blank?
        already_associated = true
      end
      if already_associated
        render :text => "This selected manager is already associated with a Money Manager", :layout => false
      else
        render :text => "Available", :layout => false
      end
    else
      if params[:manager_name].blank?
        render :text => "", :layout => false
      else
        render :text => "Manager not Found", :layout => false
      end
    end
  end
  
  def deleted_managers
    @managers = Manager.paginate :page => params[:page], :per_page => 25, :conditions => {:status => "deleted"}, :order => "name"
    render :action => "list"
  end
  
  def approve_manager
    manager = Manager.find(params[:id])
    if manager
      manager.status = "approved"
      if manager.funds
        manager.funds.each do |fund|
          fund.update_attributes(:approved_at => Date.today, :approver_id => current_user.id, :status => "approved")
        end
      end
      manager.approved_at=Date.today
      manager.approver_id=current_user.id
      manager.save
    end
    redirect_to :action => "deleted_managers"
  end


  

  def update_url
    begin
      if params[:id]
        manager = Manager.find(params[:id])
        manager.image_url = APP_CONFIG["WEBSNAPR_URL"] + manager.url
        manager.save
      else
        managers = Manager.find(:all, :conditions => "image_remote_url is null")
        managers.each { |mgr|
          mgr.image_url = APP_CONFIG["WEBSNAPR_URL"] + mgr.url
          mgr.save
        }
      end
    rescue
    end
    render :nothing => true
  end
end
