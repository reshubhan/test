class AdminController < ApplicationController
  before_filter :login_required
  layout :choose_layout
  access_control [:index, :csv_import, :approve_user, :upload, :users, :advance_users_search] => 'admin'
  after_filter :store_location, :only => [:index, :csv_import, :approve_user, :upload, :users]
  require 'csv'

  def choose_layout
    if params[:format] == 'xls'
      nil
    else
      'admin'
    end
  end
  
  def index
    redirect_to('/admin/active_users')
  end
  
  def users
    if params[:search]
      session[:search] = params[:search]
      if !params[:change_plan].blank?
        session[:change_plan]=true
      end
    else
      if params[:page].blank?
        session[:search] = nil
        session[:change_plan] = nil
      end
    end
    if !params[:change_plan].blank? or session[:change_plan]
      @change_plan = params[:change_plan]
      @users = User.descend_by_created_at.search(session[:search]).login_not_like('Anonymous').status_equals("approved").paginate( :per_page => 25, :page => params[:page])
    else
      @users = User.descend_by_created_at.search(session[:search]).login_not_like('Anonymous').status_does_not_equal("approved").paginate( :per_page => 25, :page => params[:page])
    end
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "users_results"
        if params[:search]
          page.call 'done'
        end
      end
    end
  end

  def db_backup
    system "rake backup "
    "Back up taken"
    render :nothing => true,:text => "Back up taken at #{Time.now}",:layout => "main"
  end

  def active_users
    if params[:search]
      session[:search] = params[:search]
    else
      if params[:page].blank?
        session[:search] = nil
      end
    end
    @users = User.descend_by_id.search(session[:search]).login_does_not_equal('Anonymous', 'admin').status_equals("approved").paginate( :per_page => 25, :page => params[:page])
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "users_results"
        if params[:search]
          page.call 'done'
        end
      end
    end
  end

  def approve_user
    @user = User.find(params[:id])
    @user.approver = current_user
    @user.approved_at = Date.today
    @user.status = "approved"
    @user.activation_code=nil
    if @user.plan.fee == 0
      @user.paid = true
    end
    if !@user.start_date.blank? && (@user.start_date.day >= 15) && (@user.plan.no_of_emails == 5)
      @user.emails = 3
    else
      @user.emails = @user.plan.no_of_emails
    end
    @user.save(false)
    log = Log.new(:creator => current_user, :action => "user approved", :message => "User:#{@user.login},ApprovedBy:#{current_user.login}")
    begin
      Mailer.deliver_user_approval_mail(@user)
    rescue
    end
    flash[:notice] = "User <b>#{@user.login}</b> has been activated."
    redirect_to :action => "users"
  end

  def organization_types_for_plan
    user=User.find(params[:user_id])
    role=Plan.find(params[:plan_id]).role
    @organization_types=OrganizationType.find(:all,:conditions=>{:role_id=>role.id})
    html="<select style=\"height: 23px; width: 130px;\" name=\"user[organization_type]\" id=\"organization_type\">"
    @organization_types.each { |organization_type|
      html+="<option value=\"#{organization_type.id}\">#{organization_type.name}</option>"
    }
    html+="</select>"
    render(:update) do |page|
      page.replace_html "organization_type_div_#{user.id}", html
    end
  end

  def change_user_profile
    user = User.find(params[:id])
    plan = Plan.find(params[:user][:plan_id])
    if params[:user][:show_user_name]
      user.update_attribute(:show_user_name, true)
    else
      user.update_attribute(:show_user_name, false)
    end
    if params[:user][:admin_fee] != 0 && !params[:user][:admin_fee].blank? && params[:user][:admin_fee] != user.plan.fee
      if user.paypal_profile_id
        response = GATEWAY.update_profile(user.paypal_profile_id, :amount => params[:user][:admin_fee], :start_date => Date.today+1)
        user.admin_fee = params[:user][:admin_fee]
      else
        err_msg = "User doesn't have a paypal profile. The new amount couldn't be updated."
      end
    end

    if !params[:user][:start_date].blank? && Date.strptime(params[:user][:start_date], "%Y-%m-%d") != user.start_date
      user.start_date = Date.strptime(params[:user][:start_date], "%Y-%m-%d")
    end
    if !params[:user][:end_date].blank? && Date.strptime(params[:user][:end_date], "%Y-%m-%d") != user.end_date
      user.end_date = Date.strptime(params[:user][:end_date], "%Y-%m-%d")
    end

    user.profile.update_attribute("organization_type_id", params[:user][:organization_type].to_i) if params[:user][:organization_type]
    if !params[:user][:start_date].blank? && (Date.strptime(params[:user][:start_date], '%Y-%m-%d').day >= 15) && (plan.no_of_emails == 5)
      user.emails = 3
    else
      user.emails = plan.no_of_emails
    end
    user.plan_id=plan.id
    user.views=plan.no_of_views
    user.replies=plan.no_of_replies
    user.paid=true
    user.save(false)
    render(:update) do |page|
      if err_msg && !err_msg.blank?
        page.replace_html 'successDiv', err_msg
      elsif !response || (response && response.success?)
        page.replace_html 'successDiv', 'User upgraded successfully'
      else
        page.replace_html 'successDiv', response.message
      end
    end
  end

  def upload
    @action = params[:id]
  end

  def upload_image
  end

  def create_or_get_asset(asset_name)
    Asset.find_or_create_by_name(asset_name)
  end

  def create_or_get_sector(sector_name)
    Sector.find_or_create_by_name(sector_name)
  end

  def funds
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            if (not row[0].blank?) && Fund.find_by_name(row[0]).blank?
              if validate_fund(row)
                currency = nil
                asset = nil
                sector = nil
                if Currency.find_by_name(row[5]).blank?
                  currency = Currency.create(:name => row[5])
                else
                  currency = Currency.find_by_name(row[5])
                end
                s=row[1].to_i
                in_market=false
                in_market = (row[4].downcase=="yes" ? true : false) unless row[4].blank?
                fund = Fund.create(:name=>row[0],:size=>s,:year=>row[2],:manager_id=>Manager.find_by_name(row[3]).id,:in_market=>in_market,:currency=>currency.id, :user_id=>2)
                unless fund.id.blank?
                  sql = ActiveRecord::Base.connection();

                  if !row[6].blank?
                    row[6].split(",").each { |asset_name|
                      asset=create_or_get_asset(asset_name)
                      sql.execute "insert into assets_funds values (#{asset.id}, #{fund.id});"
                    }
                  end
                  if !row[7].blank?
                    row[7].split(",").each { |asset_name|
                      asset = create_or_get_asset(asset_name)
                      sql.execute "insert into assets_funds values (#{asset.id}, #{fund.id});"
                    }
                  end
                  if !row[8].blank?
                    row[8].split(",").each { |asset_name|
                      asset = create_or_get_asset(asset_name)
                      sql.execute "insert into assets_funds values (#{asset.id}, #{fund.id});"
                    }
                  end
                  if !row[9].blank?
                    row[9].split(",").each { |asset_name|
                      asset = create_or_get_asset(asset_name)
                      sql.execute "insert into assets_funds values (#{asset.id}, #{fund.id});"
                    }
                  end
                  if !row[10].blank?
                    sector = create_or_get_sector(row[10])
                    sql.execute "insert into funds_sectors values (#{fund.id}, #{sector.id});"
                  end
                  if !row[11].blank?
                    sector = create_or_get_sector(row[11])
                    sql.execute "insert into funds_sectors values (#{fund.id}, #{sector.id});"
                  end
                  if !row[12].blank?
                    sector = create_or_get_sector(row[12])
                    sql.execute "insert into funds_sectors values (#{fund.id}, #{sector.id});"
                  end
                  if !row[13].blank?
                    sector = create_or_get_sector(row[13])
                    sql.execute "insert into funds_sectors values (#{fund.id}, #{sector.id});"
                  end
                  logger.info  "a fund has been saved !!!!!!!! \n Fund id:#{fund.id}\nFund name:#{fund.name}"
                end
              end
            end
          end
        end
        flash[:error] = "Funds added successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload", :id=>"funds"
  end

  def classified_funds
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        parsed_file=CSV::Reader.parse(params[:dump][:file])
        line_no=0
        first_row = true
        updated_fund=0
        created_fund=0
        skipped_fund=0
        parsed_file.each do |row|
          line_no+=1
          if first_row
            first_row=false
          else
            if (not row[7].blank?)&& (row[1]=="buy") # mandatory fieilds check of fund to buy.
              if row[10].blank? && row[11].blank?
                userid=(Profile.find(:first,:conditions=>{:firstname=>"admin",:lastname=>"admin"})).user_id
              else
                profile=Profile.find(:first,:conditions=>{:firstname=>row[10],:lastname=>row[11]})
                if profile
                  userid=profile.user_id
                else
                  userid=(Profile.find(:first,:conditions=>{:firstname=>"admin",:lastname=>"admin"})).user_id
                end
              end
              user=User.find_by_id(userid)
              if row[3].blank?
                if row[7]
                  asset=( Asset.find_by_id(row[7]) ? Asset.find_by_id(row[7]): Asset.find_by_name(row[7]))
                  assetid=asset.id
                end
                if row[8]
                  assettype=( Asset.find_by_id(row[8]) ? Asset.find_by_id(row[8]): Asset.find_by_name(row[8]))
                  assettypeid=assettype.id
                end
                if row[6]
                  geo=( Geography.find_by_id(row[6]) ? Geography.find_by_id(row[6]): Geography.find_by_name(row[6]))
                  geoid=geo.id
                end
                logger.info  "Asset is #{(row[7].blank? ? "Any":(Asset.find_by_id(assetid).name))}and asset type is #{(row[8].blank? ? "Any":(Asset.find_by_id(assettypeid).name))}and geography is #{(row[6].blank? ? "Any":((Geography.find_by_id(geoid)).name))}."
                desc=user.plan.role.title+" is looking to invest "+(row[5]?row[5]:"Any")+" in "+(row[7].blank? ? "Any":(Asset.find_by_id(assetid).name))+" "+(row[8].blank? ? "Any":(Asset.find_by_id(assettypeid).name))+" with fund size "+(row[4]?row[4]:"Any")+" focused on "+ (row[6].blank? ? "Any":((Geography.find_by_id(geoid)).name))
              end
              if row[0].blank? && !row[1].blank?
                classified_fund = ClassifiedFund.create(:classified_fund_type=>row[1],:user_id=>userid,:description=>(row[3]?row[3]:desc),:desired_size_id=>(row[5] ? DesiredSize.find_by_name(row[5]).id : 2),:fund_size=>(row[4] ? row[4]:"Any"),:geography_id=>(row[6]? row[6]:1),:asset_id=>row[7],:asset_type_id=>(row[8]?row[8]:""))
                created_fund+=1
                logger.info  "No of Created Classified Fund are #{created_fund}with Row no as #{line_no}  ."
                flash[:error] = "Classified Funds added successfully"
              else
                if !row[1].blank?
                  cf=ClassifiedFund.find(:all).size
                  if cf>=row[0].to_i
                    classified_fund=ClassifiedFund.find_by_id(row[0])
                    classified_fund.update_attributes(:classified_fund_type=>row[1],:user_id=>userid,:description=>(row[3]?row[3]:desc),:desired_size_id=>(row[5] ? DesiredSize.find_by_name(row[5]).id : 2),:fund_size=>(row[4] ? row[4]:"Any"),:geography_id=>(row[6]? row[6]:1),:asset_id=>row[7],:asset_type_id=>(row[8]?row[8]:""))
                    updated_fund+=1
                    logger.info  "No of Updated Classified Fund are #{updated_fund}with Row no as #{line_no}."
                  else
                    ClassifiedFund.create(:classified_fund_type=>row[1],:user_id=>userid,:description=>(row[3]?row[3]:desc),:desired_size_id=>(row[5] ? DesiredSize.find_by_name(row[5]).id : 2),:fund_size=>(row[4] ? row[4]:"Any"),:geography_id=>(row[6]? row[6]:1),:asset_id=>row[7],:asset_type_id=>(row[8]?row[8]:""))
                    created_fund+=1
                    logger.info  "No of Created Classified Fund are #{created_fund} with Row NO as #{line_no}."
                  end
                end
              end
            else
              skipped_fund+=1
              logger.info  "No of Classified Fund #{skipped_fund} with Row NO as #{line_no} has been skipped."
            end
          end
        end
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating Classified Funds . Please varify csv and retry."
      end
    end
    redirect_to :action => "upload", :id=>"classified_fund"
  end
  
  def validate_fund(row)
    if row[0].blank? || row[1].blank? || row[2].blank? || row[3].blank? || row[4].blank? || row[5].blank? || Manager.find_by_name(row[3]).blank?
      false
    else
      true
    end
  end

  def managers
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            if (not row[0].blank?) && (Manager.find_by_name(row[0]).blank?)
              geography = nil
              asset = nil
              if validate_manager(row)
                featured = false
                if Geography.find_by_name(row[2]).blank?
                  geography = Geography.create(:name => row[2])
                else
                  geography = Geography.find_by_name(row[2])
                end
                if Asset.find_by_name(row[3]).blank?
                  asset = Asset.create(:name => row[3])
                else
                  asset = Asset.find_by_name(row[3])
                end
                featured = (row[4].downcase=="yes" ? true : false) unless row[4].blank?
                Manager.create(:name=>row[0],:url=>row[1],:geography_id=>geography.id,:asset_primary_id=>asset.id,:featured=>featured, :description=>asset.name, :user_id=>2)
              end
            end
          end
        end
        flash[:error] = "Managers added successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload", :id=>"managers"
  end

  def validate_manager(row)
    if row[0].blank? || row[1].blank? || row[2].blank? || row[3].blank?
      false
    else
      true
    end
  end

  def geographies
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            if not row[0].blank? && Geography.find_by_name(row[0]).blank?
              Geography.create(:name=>row[0])
            end
          end
        end
        flash[:error] = "Geographies added successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload"
  end

  def currencies
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            if not row[0].blank? && Currency.find_by_name(row[0]).blank?
              Currency.create(:name=>row[0])
            end
          end
        end
        flash[:error] = "Currencies added successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload"
  end

  def sectors
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            if not row[0].blank? && Sector.find_by_name(row[0]).blank?
              Sector.create(:name=>row[0])
            end
          end
        end
        flash[:error] = "Sectors added successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload"
  end

  def update_users_organization_types
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          if firstRow
            firstRow=false
          else
            unless row[6].blank?
              if OrganizationType.find_by_name(row[6]).blank?
                organization_type = OrganizationType.create(:name=>row[6], :role_id=>Role.find_by_title(row[5]).id )
              else
                organization_type = OrganizationType.find_by_name(row[6])
              end
              User.find_by_login(row[0]).profile.update_attribute("organization_type_id", organization_type.id) if User.find_by_login(row[0])
            end
          end
        end
        flash[:error] = "Organization type updated successfully"
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Error occured while updating organization type. Please varify csv and retry."
      end
    end
    redirect_to :action => "upload"
  end

  #    CSV upload for the following file format
  #    0 Manager Name - required
  #    1 url - required
  #    2 Fund Name - required
  #    3 Description - required
  #    4 Asset Class Primary - required
  #    5 Asset Class - optional
  #    6 Geography Main - required
  #    7 Geography - optional
  #    8 Size - required
  #    9 Vintage - required
  #    10 Type - optional
  #    11 In Market - optional
  #    12 Date Reported - optional
  def csv_import
    if params[:dump][:file].blank?
      flash[:error] = "Please select a CSV file to upload"
    else
      asset_count = geography_count = manager_count = fund_count = row_count = 0
      total_count_array = Array.new
      total_saved_rows = Array.new
      error_message = ""
      begin
        @parsed_file=CSV::Reader.parse(params[:dump][:file])
        firstRow = true
        @parsed_file.each do |row|
          unless firstRow
            asset_saved = geography_saved = manager_saved = fund_saved = true
            new_asset = new_geography = new_manager = new_fund = false
            row_count += 1
            total_count_array << row_count
            # Creating asset if it does not exists
            asset = Asset.find_by_name(row[4])
            if (asset.nil?)
              asset = Asset.new
              asset.name = row[4]
              if asset.save
                asset_count += 1
                new_asset = true
              else
                error_message += " Line : " + row_count.to_s + " Error : " + asset.errors.full_messages.to_s + "<br/>"
                asset_saved = false
              end
            end
            secondary_asset = Asset.find_by_name(row[5])
            if (secondary_asset.nil?)
              secondary_asset = Asset.new
              secondary_asset.name = row[5]
              secondary_asset.save
            end

            # Creating geography if it does not exists
            geography = Geography.find_by_name(row[6])
            if (geography.nil?)
              geography = Geography.new
              geography.name=row[6]
              if geography.save
                geography_count +=1
                new_geography = true
              else
                error_message += " Line : " + row_count.to_s + " Error : " + geography.errors.full_messages.to_s + "<br/>"
                geography_saved = false
              end
            end

            # Creating manager if not present
            manager = Manager.fetch_manager(row[0], asset.id, geography.id)
            if(manager.nil?)
              manager = Manager.new
              manager.name = row[0]
              manager.url = row[1]
              manager.description = row[3]
              manager.asset_primary_id = asset.id
              manager.asset_secondary_id = secondary_asset.id
              manager.geography_id = geography.id
              manager.geography_sub = row[7]
              manager.user_id = current_user.id
              if !row[12].blank?
                manager.created_at = Date.parse( row[12] )+1
              end
              if manager.save
                manager_count += 1
                new_manager = true
              else
                error_message = getFormattedErrorMessage(error_message, manager, row_count)
                manager_saved = false
              end
            end
            # Creating fund
            if manager_saved
              fund = Fund.new
              fund.name = row[2]
              fund.fund_type = row[10]
              fund.size = row[8]
              fund.year = row[9]
              if !row[11].blank? and row[11].downcase.eql?('false')
                fund.in_market = 0
              else
                fund.in_market = 1
              end
              fund.manager_id = manager.id
              fund.manager_name = manager.name
              fund.user_id = current_user.id
              if !row[12].blank?
                fund.created_at = Date.parse( row[12] )+1
              end
              if fund.save
                fund_count += 1
                new_fund = true
              else
                error_message = getFormattedErrorMessage(error_message, fund, row_count)
                fund_saved = false
              end
            end
          
            # Check if the entire row is saved without any errors
            if asset_saved and geography_saved and manager_saved and fund_saved
              total_saved_rows << row_count
            else
              if new_asset
                asset.destroy
                asset_count -= 1
              end
              if new_geography
                geography.destroy
                geography_count -= 1
              end
              if new_manager
                manager.destroy
                manager_count -= 1
              end
              if new_fund
                fund.destroy
                fund_count -= 1
              end
            end
          else
            firstRow = false;
          end
        end
        flash[:message] = "Uploaded #{asset_count} Assets, #{geography_count} Geographies, #{manager_count} Managers and #{fund_count} Funds."
        flash[:failure_notice] = error_message.to_s
      rescue Exception => e
        logger.error(e.backtrace)
        flash[:error] = "Please select a CSV file to upload"
      end
    end
    redirect_to :action => "upload"
  end

  def approve
    @manager = Manager.find(params[:id])
    if @manager.new_name == nil
      if @manager.new_url != nil
        @manager.url = @manager.new_url
      end
    else
      @manager.name = @manager.new_name
      if @manager.new_url != nil
        @manager.url = @manager.new_url
      end
    end
    @manager.new_name =  nil
    @manager.new_url = nil
    @manager.save
    redirect_to :action => "manager_updates"
  end

  def disapprove
    @manager = Manager.find(params[:id])
    @manager.new_name = nil
    @manager.new_url =nil
    @manager.save
    redirect_to :action => "manager_updates"
  end

  def manager_updates
    @managers = Manager.find(:all, :conditions => ["new_url IS NOT NULL OR new_name IS NOT NULL"])
  end

  def export_active_users
    @export = params[:export]
    @users = User.find_active_users(@export)
    respond_to do |format|
      format.html
      format.xls if params[:format] == 'xls'
    end
  end

  protected

  def permission_denied
    flash[:notice] = "Sorry, You don't have privileges to access this action"
    return redirect_back_or_default('/')
  end

  def getFormattedErrorMessage(error_message, obj, row_count)
    error_message += " Line : " + row_count.to_s + " Error : "
    obj.errors.each { |key, value|
      if key.downcase.eql?('url')
        error_message += " " + key + " " + value + ", sample url : www.trustedinsightinc.com,"
      else
        error_message += " " + key + " " + value + ","
      end
    }
    return error_message[0, error_message.size-1] + "<br/>"
  end
end
