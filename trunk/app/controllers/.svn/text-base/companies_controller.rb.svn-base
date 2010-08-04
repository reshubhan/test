class CompaniesController < ApplicationController
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
  layout :company_layout
  after_filter :store_location, :only => [:index, :new, :show, :edit]
  access_control [:delete_postings] => 'admin'

  def company_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end

  def  company_mail
    @company = company.find(params[:id])
    if @company and (current_user.emails != 0) and !UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'Email', :regarding_type => 'user', :regarding_id => @company.user.id})
      if current_user.emails != -1
        current_user.update_attribute("emails", current_user.emails - 1)                    #Update user's data.
      end
      UserActivity.create({:user_id => current_user.id, :activity => 'Email', :regarding_type => 'user', :regarding_id => @company.user.id})
    end
    render :nothing => true
  end

  def params_saved
    session[:fund_checked_value]=nil
    if params[:company_asset_id].size==2
      params[:company_asset_id].each do |id|
        asst=Asset.find(id)
        if asst.name=="Venture Capital"
          session[:venture]=nil
          session[:venture]=params
        elsif asst.name=="Growth Capital"
          session[:growth]=nil
          session[:growth]=params
        end
      end
    else
      asst=Asset.find(params[:company_asset_id].to_s)
      case (asst.name)
      when "Distressed"
        session[:distressed]=nil
        session[:distressed]=params
      when "Real Estate"
        session[:real_assets]=nil
        session[:real_assets]=params
      when "Buyout"
        session[:buyout]=nil
        session[:buyout]=params
      end
    end
    unless session[:checked_value].blank?
      session[:checked_value] <<'_'
      session[:checked_value] << params[:company_asset_id][0]
      session[:checked_value]=session[:checked_value].split('_')
    else
      session[:checked_value]=params[:company_asset_id][0]
    end
    redirect_to :action => :new_directs_to_buy, :controller => :companies, :new => true
  end
  
  def new_directs_to_buy
    session[:fund_checked_value]=nil
    @sectors = Sector.find(:all)
    @geos = Geography.find(:all)
    if params[:company_asset_id]
      params[:company_asset_id] << "9" if (params[:company_asset_id].include? "8") && (!params[:company_asset_id].include? "9")
      render :action => "new_directs" , :asset_id => params[:company_asset_id]
    else
      if !params[:new]
        @new = true
        session[:distressed]=nil
        session[:buyout]=nil
        session[:real_assets]=nil
        session[:venture]=nil
        session[:growth]=nil
      end
      params[:commit].blank? ? flash[:error] ="" : flash[:error] = "Please Choose at least One Option"
    end
  end

  def directs_to_investment_criteria
    session[:checked_value]=nil
    error = nil
    if session[:distressed]
      session[:value]=session[:distressed]
    elsif session[:buyout]
      session[:value]=session[:buyout]
    elsif session[:real_assets]
      session[:value]=session[:real_assets]
    elsif session[:venture]
      session[:value]=session[:venture]
    elsif session[:growth]
      session[:value]= session[:growth]
    end
    flag=false
    geos = Geography.find(:all,:conditions =>"name in ('Us','Asia','Europe')",:select=>'id').map {|x| x.id}
    sectors=Sector.find_by_sql("Select id from sectors ")
    ActiveRecord::Base.transaction do
      old_postings = Company.find(:all, :conditions => "company_type = 'buy' AND user_id = #{current_user.id}")
      old_postings.each do |posting|                                  # delete old postings by the users before creating new ones.
        posting.update_attribute('status', 'deleted')
      end
      unless params[:company_asset_id].blank?
        if params[:company_asset_id].include?(8)
          params[:company_asset_id].push(9)
        end
        params[:company_asset_id].each do |asset_id|
          if session[:value] && asset_id.to_s==(session[:value][:company_asset_id][0])
            error = newdirects_upload(session[:value])
            flag=true if error.nil?
          else
            ActiveRecord::Base.transaction do
              transaction_type=TransactionType.find(:all,:conditions=>{:asset_id=>asset_id})
              geos.each do |geo|
                company = Company.new(:geography_id=>geo,:asset_id=>asset_id,:type_of_financing=>Company::TYPE_OF_FINANCING[0],:desired_size_id=>1,:company_type=>"buy",:user_id=>current_user.id,:revenue_per_year=>Company::TARGET_REVENUE[0],:target_ebitda=>Company::TARGET_EBITDA[0],:transaction_id=>transaction_type[0].id)
                company.sector_ids=sectors
                company.creator = current_user
                company.save
              end
            end
            flag=true
          end
        end
        session[:value]=nil
        if flag
          if Question.find_by_sql("select * from questions q inner join questions_roles qr on q.id=qr.question_id where qr.role_id=#{current_user.plan.role.id} and q.status=true").blank?
            redirect_to :controller=>"classified_funds",:action=>"index"
          else
            flash[:notice] = 'Directs/Co-investments were successfully created.'
            render :template => "questions/list_question"
          end
        else
          flash[:error] = "Something went wrong while creating your postings, please try again."
          render :template => "companies/new_directs_to_buy"
        end
      else
        if Question.find_by_sql("select * from questions q inner join questions_roles qr on q.id=qr.question_id where qr.role_id=#{current_user.plan.role.id} and q.status=true").blank?
          redirect_to :controller=>"classified_funds",:action=>"index"
        else
          flash[:notice] = 'Directs/Co-investments creation was skipped.'
          render :template => "questions/list_question"
        end
      end
    end
  end

  def newdirects_upload(params)
    error = nil
    @sectors = Sector.find(:all)
    @geos = Geography.find(:all)
    assets = Asset.find(:all, :conditions => "id in ('#{params[:company_asset_id].join("','")}')") if params[:company_asset_id].size >1
    assets = Asset.find(params[:company_asset_id]) if params[:company_asset_id].size == 1
    ast=[]
    for asst in assets
      ast << params[:companies]['asset'+asst.id.to_s][:assets] if params[:companies]['asset'+asst.id.to_s][:assets]
      assets = Asset.find(ast) if ast
    end
    status=false
    flag = true
    email_check_in_description=false
    asset_blank=true
    unless assets.blank?
      assets.each do |asset|
        length=params[:companies]['asset'+asset.id.to_s][:sector_ids].size.to_i
        params[:companies]['asset'+asset.id.to_s][:sector_ids].slice!(-(length))
        sectors=params[:companies]['asset'+asset.id.to_s][:sector_ids]
        unless params[:companies].blank? || params[:companies]['asset'+asset.id.to_s].blank? || params[:companies]['asset'+asset.id.to_s][:geographies].blank? || params[:companies]['asset'+asset.id.to_s][:type_of_financing].blank? || sectors.blank? || params[:companies]['asset'+asset.id.to_s][:desired_size].blank?||params[:companies]['asset'+asset.id.to_s][:revenue].blank?||params[:companies]['asset'+asset.id.to_s][:ebitda].blank?||params[:companies]['asset'+asset.id.to_s][:transaction_types].blank?||
            params[:companies]['asset'+asset.id.to_s][:transaction_types].each do |transaction_type|
            params[:companies]['asset'+asset.id.to_s][:type_of_financing].each do |financing_type|
              params[:companies]['asset'+asset.id.to_s][:geographies].each do |geo|
                params[:companies]['asset'+asset.id.to_s][:revenue].each do |revenue|
                  params[:companies]['asset'+asset.id.to_s][:ebitda].each do |ebitda|
                    if (params[:description].gsub( /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/ ,"Email_id"))=="Email_id" && (email_check_in_description==false)
                      Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"Direct/Co-investment to buy")
                      email_check_in_description=true
                    end
                    company = Company.new(:geography_id=>geo,:description=>( params[:description].blank? ?  nil : params[:description]  ),:asset_id=>asset.id,:type_of_financing=>financing_type,:desired_size_id=>params[:companies]['asset'+asset.id.to_s][:desired_size],:company_type=>"buy",:user_id=>current_user.id,:revenue_per_year=>revenue,:target_ebitda=>ebitda,:transaction_id=>transaction_type)
                    company.sectors=@sectors
                    company.creator = current_user
                    company.save
                    status=true
                  end
                end
              end
            end
          end
        else
          error = 'Please select atleast one option from each field'
          flag = false
        end
      end
    else
      asset_blank=false
      error = 'Please select atleast one Asset '
    end
    if  flag && status && asset_blank
      flash[:notice] = 'Directs/Co-investments were successfully created.'
    end
  end

  def check_assets
    geos=Geography.find(:all)
    assets=params[:id].split("10")
    render :update do |page|
      assets.each do |asset|
        j=0
        k=0
        l=0
        m=0
        n=0
        o=0
        transaction_types=TransactionType.find(:all,:conditions=>{:asset_id=>asset})
        transaction_types.each do |transaction_type|
          if params[:value]=="check_all"
            page.call :check_all_assettype,asset+'transaction_checkbox'+o.to_s
          else
            page.call :uncheck_all_assettype,asset+'transaction_checkbox'+o.to_s
          end
          o=o+1
        end
        (Company::TYPE_OF_FINANCING).each do |type_of_financing|
          if params[:value]=="check_all"
            page.call :check_all_assettype,asset+'financing_checkbox'+j.to_s
          else
            page.call :uncheck_all_assettype,asset+'financing_checkbox'+j.to_s
          end
          j=j+1
        end
        geos.each do|geography|
          if params[:value]=="check_all"
            page.call :check_all_assettype, asset+'geography_checkbox'+k.to_s
          else
            page.call :uncheck_all_assettype, asset+'geography_checkbox'+k.to_s
          end
          k=k+1
        end
        (Company::DESIRED_SIZE).each do |desired_size|
          if params[:value]=="check_all"
            page.call :check_all_assettype,asset+'desired_size_checkbox'+l.to_s
          else
            page.call :uncheck_all_assettype,asset+'desired_size_checkbox'+l.to_s
          end
          l=l+1
        end
        (Company::TARGET_REVENUE).each do |target_revenue|
          if params[:value]=="check_all"
            page.call :check_all_assettype,asset+'target_revenue_checkbox'+m.to_s
          else
            page.call :uncheck_all_assettype,asset+'target_revenue_checkbox'+m.to_s
          end
          m=m+1
        end
        (Company::TARGET_EBITDA).each do |target_ebitda|
          if params[:value]=="check_all"
            page.call :check_all_assettype,asset+'target_ebitda_checkbox'+n.to_s
          else
            page.call :uncheck_all_assettype,asset+'target_ebitda_checkbox'+n.to_s
          end
          n=n+1
        end
      end
    end
  end


  def index
    @type = params[:type].blank? ? 'buy' : params[:type]
    #    @browseby = 'popular'
    @financing = @sector = @geography = @deal_type = @asset_type = 'Any'
    @desired_size = 'Any Size'
    @companies, @total, @amount_total = Company.company_results(params)
    @heading = Company.getheading(params)
  end

  def profile_company_list
    if current_user.has_role('Admin')
      user_id=params[:user_id]
    else
      user_id=current_user.id
    end
    if params[:type]=="buy"
      @company_buy=Company.profile_results(params[:page],user_id,params[:type])
    else
      @company_sell=Company.profile_results(params[:page],user_id.id,params[:type])
    end
    render(:update) do |page|
      if params[:type]=="buy"
        page.replace_html 'companyBuy', :partial => 'profile_results',:locals =>{:companies =>@company_buy,:type => params[:type]}
      else
        page.replace_html 'companySell', :partial => 'profile_results',:locals =>{:companies =>@company_sell,:type => params[:type]}
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

    #    @browseby = params[:search][:browse_by].blank? ? 'popular' : params[:search][:browse_by]
    @deal_type = params[:search][:deal_type].blank? ? 'Any': params[:search][:deal_type]
    @asset_type = params[:search][:asset_type].blank? ? 'Any': params[:search][:asset_type]
    @geography = params[:search][:geography].blank? ? 'Any' : params[:search][:geography]
    @financing = params[:search][:financing].blank? ? 'Any' : params[:search][:financing]
    @sector = params[:search][:sector].blank? ? 'Any': params[:search][:sector]
    @desired_size = params[:search][:desired_size].blank? ? 'Any Size' : params[:search][:desired_size]
    
    @type = params[:search][:type].blank? ? 'buy' : params[:search][:type]
    @orderby = params[:orderby].blank? ? nil : params[:orderby]
    if params[:ascdesc] and params[:ascdesc].eql?'desc'
      @ascdesc = 'asc'
    else
      @ascdesc = 'desc'
    end

    @save_search = true if !params[:page] && !@srch
    
    @companies, @total, @amount_total= Company.company_results( params[:search], @orderby, @ascdesc, params[:page])
    @heading = Company.getheading(params[:search])
   
    if !request.xhr?
      render :action => 'index'
    else
      render(:update) do |page|
        page.replace_html 'buy', :partial => 'companies/results', :locals => {:companies => @companies, :type => @type}
      end
    end
  end

  def save_search
    success=SavedSearch.save_search(params[:search], session[:user_id], 'company', params[:id])
    @saved_searches = SavedSearch.find(:all, :conditions => ["user_id = ? AND search_type = 'company'", session[:user_id]])
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
  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])
    if @company
      unless UserActivity.find(:first, :conditions => {:user_id => current_user.id, :activity => 'View', :regarding_type => 'company', :regarding_id => @company.id})
        current_user.update_attribute("views", current_user.views - 1)
        UserActivity.create({:user_id => current_user.id, :activity => 'View', :regarding_type => 'company', :regarding_id => @company.id})
      end
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    @company.company_type = params[:id]
    @user = "select co.* from companies co inner join users on co.user_id = id"
    if @company.company_type == 'buy'
      render :action => "upload_buy"
    elsif @company.company_type == 'sell'
      render :action => "upload_sell"
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  
  # POST /companies
  # POST /companies.xml
  def create
    if params[:company][:company_type]=="sell"
      if params[:company][:sector_ids]=="All available"
        params[:sector_ids]=Sector.find(:all).id
      else
        len=params[:company][:sector_ids].size.to_i
        params[:company][:sector_ids].slice!(-(len))
        asts=params[:company][:sector_ids]
        params[:company][:sector_ids]=asts
      end
    end
    @company = Company.new(params[:company])
    if current_user.has_role('Admin')
      if params[:company][:user_login].blank?
        @company.admined = true
      else
        @company.admined = false
      end
      @user = User.find_by_login(params[:company][:user_login])
      if  @user.blank? || @user.id==1
        flash[:notice] = 'Not a valid User Name choose a user from dropdown'
        if @company.type_buy
          render :action => :upload_buy
        else
          render :action => :upload_sell
        end
      else
        @company.user_id=@user.id
        @company.creator = current_user
        if  @company.save
          if (params[:company][:description].gsub( /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/,''))
            Mailer.deliver_email_alert_mail(current_user.profile.fullname,current_user.login,"Direct/Co-investment to sell")
          end
          flash[:notice] = 'Direct/Co-Investment was successfully created.'
          if  @company.type_sell
            redirect_to :action => "index", :type=> @company.company_type
          end
          if  @company.type_buy
            redirect_to :action => "index", :type=>  @company.company_type
          end
        else
          if @company.type_buy
            render :action => :upload_buy
          else
            render :action => :upload_sell
          end
        end
      end
    else
      if current_user.plan.name=='Basic' && current_user.credit < 1 && @company.type_sell && ( not current_user.has_role('Admin'))
        redirect_to :controller => "companies", :action => "upload", :id => 'sell'
        flash[:notice] = "You need to pay an amount of $29 to add a Direct/Co-Investment to sell."
      else
        @company.user_id = current_user.id
        @company.creator = current_user
        if @company.save
          @user = User.find_by_id(current_user.id)
          if (current_user.plan.name=='Basic')
            @user.credit = (@user.credit - 1)
          end
          flash[:notice] = 'Direct/Co-investment was successfully created.'
          @user.save
          redirect_to :action => "index", :type => @company.company_type
        else
          render :action => "upload_#{@company.company_type}"
        end
      end
    end
  end
  
  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])
    @company.updater = current_user
    length=params[:company][:sector_ids].size.to_i
    params[:company][:sector_ids].slice!(-(length))
    sectors=params[:company][:sector_ids]
    params[:company][:sector_ids]=sectors
    if @company.update_attributes(params[:company])
      flash[:notice] = 'Direct/Co-Investment was successfully updated.'
      redirect_to :action => "show", :id => @company.id
    else
      if @company.type_sell
        render :action => "upload_sell"
      end
      if @company.type_buy
        render :action => "upload_buy"
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    if has_access?(@company)
      # name = @company.name+'_'+Date.today.strftime("%m/%d/%Y_%I:%M%p")
      @company.update_attribute("status", "deleted")
      redirect_to :action=>'index', :type=>@company.company_type
    else
      render :text => "Sorry! You don't have enough privilege.", :layout => "companies_layout"
    end
  end

  def delete_postings
    posts=Company.find(:all,:conditions =>{:user_id => params[:user_id]})
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
end