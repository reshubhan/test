class ClassifiedFundsController < ApplicationController
  before_filter :login_required
  layout :classified_fund_layout
  after_filter :store_location, :only => [:index, :new, :show, :edit]
  access_control [:delete_postings] => 'admin'

  def classified_fund_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end

  def index
    @geography = @institution = @asset_type = @asset_class = 'Any'
    @desired_size = @fund_size = 'Any Size'
    @type = params[:type].blank? ? 'buy': params[:type]
    @classified_funds, @total, @amount_total = ClassifiedFund.paginate_results(params)
    @heading = ClassifiedFund.getheading(params)
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
    @asset_class = params[:search][:asset_class].blank? ? 'Any' : params[:search][:asset_class]
    @asset_type = params[:search][:asset_type].blank? ? 'Any' : params[:search][:asset_type]
    @desired_size = params[:search][:desired_size].blank? ? 'Any Size' : params[:search][:desired_size]
    @fund_size = params[:search][:fund_size].blank? ? 'Any Size' : params[:search][:fund_size]
    @geography = params[:search][:geography].blank? ? 'Any' : params[:search][:geography]
    @institution = params[:search][:institution].blank? ? 'Any' : params[:search][:institution]
    @type = params[:search][:type].blank? ? 'buy' : params[:search][:type]
    @orderby = params[:orderby].blank? ? nil : params[:orderby]
    if params[:ascdesc] and params[:ascdesc].eql?'desc'
      @ascdesc = 'asc'
    else
      @ascdesc = 'desc'
    end

    @save_search = true if !params[:page] && !@srch
    
    @classified_funds, @total, @amount_total = ClassifiedFund.paginate_results(params[:search], params[:orderby], params[:ascdesc], params[:page])

    @heading = ClassifiedFund.getheading(params[:search])
    if request.xhr?
      render(:update) do |page|
        if @type.eql?'buy'
          page.replace_html 'classifiedsDivBuyer', :partial => 'results'
        else
          page.replace_html 'classifiedsDivSeller', :partial => 'new_funds_to_sell'
        end
      end
    else
      render :action => 'index'
    end
  end

  def profile_fund_list
    if current_user.has_role('Admin')
      user_id=params[:user_id]
    else
      user_id=current_user.id
    end
    @classified_fund=ClassifiedFund.profile_results(params[:page],user_id,params[:type])
    if params[:type]=="buy"
      @classified_fund_buy=@classified_fund
    else
      @classified_fund_sell=@classified_fund
    end
    render(:update) do |page|
      if params[:type]=="buy"
        page.replace_html 'fundBuy', :partial => 'profile_results', :locals => {:classified_funds => @classified_fund}
      else
        page.replace_html 'fundSell', :partial => 'profile_sell_results', :locals => {:classified_funds => @classified_fund}
      end
    end
  end

  def save_search
    success=SavedSearch.save_search(params[:search], session[:user_id], 'classified fund', params[:id])
    @saved_searches = SavedSearch.find(:all, :conditions => ["user_id = ? AND search_type = 'classified fund'", session[:user_id]])
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
  
  def getfunds
    if params[:manager_id]
      manager = Manager.find_by_id(params[:manager_id].gsub(/!!and!!/, '&'))
    end
    if manager
      render :partial => "classified_funds/sell", :locals => {:manager => manager.id, :fund => params[:fund_id].to_i}
    else
      render :text => "<select></select>"
    end

  end

  # GET /classified_funds/1
  # GET /classified_funds/1.xml
  def show
    @flag=false
    @newfundtosell = true if params[:newfundtosell]
    @classified_fund = ClassifiedFund.find(params[:id])
    @message = Message.new(:manager_id => params[:id], :sender_id => current_user.id);
    if @classified_fund
      unless UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'View', :regarding_type => 'classified_fund', :regarding_id => @classified_fund.id})
        current_user.update_attribute("views", current_user.views - 1)
        UserActivity.create({:user_id => current_user.id, :activity => 'View', :regarding_type => 'classified_fund', :regarding_id => @classified_fund.id})
      end
      if !@classified_fund.manager.blank?
        @manager = @classified_fund.manager
        @pros = AssetAttribute.find_all_attributes_by_type("pros", @manager.asset_primary_id)
        @cons = AssetAttribute.find_all_attributes_by_type("cons", @manager.asset_primary_id)
        @comments = Comment.paginate :per_page => 25, :page => params[:page], :conditions => "manager_id = #{@manager.id} and status = 'approved'", :order =>"created_at desc"
        @ratings = Rating.find_latest_rating(current_user, @manager)
      end
    end
    
    ques=Question.find(:all)
    ques.each do |q|
      if q.role_ids.include?(current_user.plan.role.id)
        @flag=true
      end
    end
    @answers = Answer.find(:all, :joins => 'inner join questions q on q.id = answers.question_id', :conditions => "q.status=true and user_id=#{@classified_fund.user_id}", :order => "q.rank asc")
  end

  def new_fund_to_buy
    if params[:retry]
      @retry = true
    end
    if params[:asset_id]
      @geos = Geography.find(:all)
      @sectors = Sector.find(:all)
      render :action => "new_funds" , :asset_id => params[:root_asset]
    else
      unless params[:new]
        @new = true
        session[:hedge_fund_value]=nil
        session[:private_equity_value]=nil
        session[:real_assets_value]=nil
      end
    end
  end

  def params_saved
    unless params[:assets]
      @geos = Geography.find(:all)
      @sectors = Sector.find(:all)
      flash[:error] = "Select at least one sub-asset."
      render :action => "new_funds", :asset_id => params[:asset_id]
    else
      if session[:token].nil?
        token= session[:token]=Time.now.to_i.to_s
      end
      asst=Asset.find(params[:asset_id].to_s)
      case (asst.name)
      when "Hedge Funds"
        session[:hedge_fund_value]=nil
        sess=SessionData.create(:token =>token ,:data =>params.to_yaml)
        sess.save
        session[:hedge_fund_value]=sess.id
      when "Real Estate"
        session[:real_assets_value]=nil
        sess=SessionData.create(:token => token,:data =>params.to_yaml)
        sess.save
        session[:real_assets_value]=sess.id
      when "Private Equity"
        session[:private_equity_value]=nil
        sess=SessionData.create(:token => token,:data =>params.to_yaml)
        sess.save
        session[:private_equity_value]=sess.id
      end
      unless session[:fund_checked_value].blank?
        session[:fund_checked_value] <<'_'
        session[:fund_checked_value] << (params[:asset_id])
        session[:fund_checked_value]=session[:fund_checked_value].split('_')
      else
        session[:fund_checked_value]=params[:asset_id]
      end
      redirect_to :action => :new_fund_to_buy, :controller => :classified_funds, :new => true
    end
  end

  def fund_to_direct_preference
    session[:fund_checked_value]=nil
    if session[:token].nil?
      session[:token]=Time.now.to_i.to_s
    end
    error = []
    ActiveRecord::Base.transaction do
      old_postings = ClassifiedFund.find(:all, :conditions => "user_id = #{current_user.id} AND classified_fund_type = 'buy'")
      old_postings.each do |posting|                                  # delete old postings by the users before creating new ones.
        posting.update_attribute('status', 'deleted')
      end
      unless params[:asset_ids].blank?
        params[:asset_ids].each do |asset_id|
          asset = Asset.find(asset_id)
          if asset.name=="Hedge Funds"
            if session[:hedge_fund_value]
              error << newfund_upload(session[:hedge_fund_value],session[:token])
            else
              error << default_upload("hedge",session[:token])
            end
          elsif asset.name=="Private Equity"
            if session[:private_equity_value]
              error << newfund_upload(session[:private_equity_value],session[:token])
            else
              error << default_upload("private",session[:token])
            end
          elsif asset.name=="Real Estate"
            if session[:real_assets_value]
              error << newfund_upload(session[:real_assets_value],session[:token])
            else
              error << default_upload("real",session[:token])
            end
          end
        end
        if error.blank?
          flash[:error] = error.join(",\n")
          render :controller => "classified_funds", :action => "new_fund_to_buy", :new => true
        else
          flash[:notice] = "Postings creation has been scheduled."
          if (current_user.plan.role.title=='Service Provider'&& current_user.profile.organization_type.name=="Consultant")
            redirect_to :controller=>"classified_funds",:action=>"index"
          else
            redirect_to :controller => "companies", :action => "new_directs_to_buy"
          end
        end
      else
        if (current_user.plan.role.title=='Service Provider'&& current_user.profile.organization_type.name=="Consultant")
          redirect_to :controller=>"classified_funds",:action=>"index"
        else
          flash[:notice] = "Postings creation is skipped."
          redirect_to :controller => "companies", :action => "new_directs_to_buy"
        end
      end
    end
  end

  def default_upload(assetObj,token)
    system "rake create_default_postings ASSET_NAME=#{assetObj} TOKEN=#{token} USER_ID=#{current_user.id} --trace >> #{Rails.root}/log/rake_tasks.log &"
    "Postings are being created, you will get a mail for confirmation once this is done."
  end

  def newfund_upload(id,token)
    system "rake create_postings ID=#{id} USER_ID=#{current_user.id} TOKEN=#{token}  --trace >> #{Rails.root}/log/rake_tasks.log  &"
    "Postings are being created, you will get a mail for confirmation once this is done."
    session[:hedge_fund_value]=nil
    session[:private_equity_value]=nil
    session[:real_assets_value]=nil
  end

  def delete_recent_postings
    ClassifiedFund.delete_all("token = #{session[:token]}")
    session[:token]=nil
    render :nothing => true
  end
  
  def delete_postings
    posts=ClassifiedFund.find(:all,:conditions =>{:user_id => params[:user_id]})
    unless posts.blank?
      posts.each do |post|
        post.update_attribute('status', 'deleted')
      end
      flash[:notice]="Your postings have been deleted."
    else
      flash[:notice]="You do not have any postings to delete. "
    end
    redirect_back_or_default("/")
  end

  def check_assets
    geos=Geography.find(:all)
    assets=params[:id].split("10")
    render :update do |page|
      assets.each do |x|
        types=Asset.find(:all,:conditions=>{:parent_id=>x})
        j=0
        k=0
        types.each do |y|
          if params[:value]=="check_all"
            page.call :check_all_assettype,x+'asset_checkbox'+j.to_s
          else
            page.call :uncheck_all_assettype,x+'asset_checkbox'+j.to_s
          end
          j=j+1
        end
        geos.each do|z|
          if params[:value]=="check_all"
            page.call :check_all_assettype,x+'geography_checkbox'+k.to_s
          else
            page.call :uncheck_all_assettype,x+'geography_checkbox'+k.to_s
          end
          k=k+1
        end
      end
    end
  end

  # GET /classified_funds/new
  # GET /classified_funds/new.xml
  def new
    @managers=Manager.find(:all, :conditions => "status = 'approved'")
    @classified_fund = ClassifiedFund.new
    @classified_fund.manager_id=params[:manager_id].to_i if params[:manager_id]
    @classified_fund.classified_fund_type = params[:id]
    if @classified_fund.classified_fund_type == 'buy'
      render :action => "upload_buy"
    elsif @classified_fund.classified_fund_type == 'sell'
      render :action => "upload_sell"
    else
      if current_user.has_role('Admin')
        redirect_to :controller => "admin", :action => "index"
      else
        redirect_to :controller => "main", :action => "index"
      end
    end
  end

  # GET /classified_funds/1/edit
  def edit
    @classified_fund = ClassifiedFund.find(params[:id])
    if @classified_fund.type_buy
      render :action => "upload_buy"
    elsif @classified_fund.type_sell
      @managers = Manager.find(:all, :conditions => "status = 'approved'")
      @classified_fund = ClassifiedFund.find(params[:id])
    end
  end

  


  # POST /classified_funds
  # POST /classified_funds.xml
  def create
    @managers=Manager.find(:all)
    @classified_fund = ClassifiedFund.new(params[:classified_fund])
    @classified_fund.user_id = current_user.id
    @classified_fund.creator = current_user
    @classified_fund.not_new_fund_buy=true
    if current_user.has_role('Admin')
      if params[:classified_fund][:user_login].blank?
        @classified_fund.admined = true
      else
        @classified_fund.admined = false
      end
      @user = User.find_by_login(params[:classified_fund][:user_login])
      if  @user.blank?|| @user.id==1
        flash[:notice] = 'Not a valid User Name choose a user from dropdown'
        render :action => "upload_buy"
      else
        @classified_fund.user_id=@user.id
        if @classified_fund.save
          flash[:notice] = 'Posting was successfully created.'
          redirect_to :action => "index", :type=> @classified_fund.classified_fund_type
        end
      end
    else
      if @classified_fund.save
        if (params[:classified_fund][:description].gsub( /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/,''))
          Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"posting to sell")
        end
        flash[:notice] = 'Classified fund was successfully created.'
        redirect_to :action => "index", :type => @classified_fund.classified_fund_type
      else
        render :action => "upload_#{@classified_fund.classified_fund_type}"
      end
    end
  end

  # PUT /classified_funds/1
  # PUT /classified_funds/1.xml
  def update
    @classified_fund = ClassifiedFund.find(params[:id])

    respond_to do |format|
      if @classified_fund.update_attributes(params[:classified_fund])
        flash[:notice] = 'ClassifiedFund was successfully updated.'
        format.html { redirect_to(@classified_fund) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classified_fund.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classified_funds/1
  # DELETE /classified_funds/1.xml
  def destroy
    @classified_fund = ClassifiedFund.find(params[:id])
    if has_access?(@classified_fund)
      @classified_fund.update_attributes(:status => 'deleted', :updated_at => Date.today, :updated_by => current_user.id)
      redirect_to :controller => 'classified_funds', :action => 'list', :id => @classified_fund.classified_fund_type
    else
      render :text => "Sorry! You don't have enough privilege.", :layout => "main"
    end
  end

  def update_asset_types
    render(:update) do |page|
      page.replace_html 'asset_types', :partial => "asset_type_dropdown", :locals => {:asset_types => Asset.get_children(params[:id])}
    end
  end

end
