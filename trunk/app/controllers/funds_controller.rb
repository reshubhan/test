class FundsController < ApplicationController
  before_filter :login_required
  auto_complete_for :manager, :name,:limit => 15
  auto_complete_for :user, :login,:limit => 15
  skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_manager_name, :auto_complete_for_user_login]
  layout :funds_layout
  access_control [:deleted_funds] => 'admin'
  
  after_filter :store_location, :only => [:index, :new, :show, :edit, :list, :destroy]
  #access_control [:list, :destroy] => 'admin'
  
  def funds_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end


  
  #  access_control [:new, :create, :update, :edit] => '( Institutional Investor | Fund Manager | Service Provider)',
  #                  :delete => 'Institutional Investor & (!Fund Manager & !Service Provider)'


  def show
    @fund = Fund.find(params[:id], :conditions => "status='approved'")
#    flash[:newfundtosell] = true
#    redirect_to :controller=>'classified_funds', :action => 'show'
  end

  def new
     @managers = Manager.find(:all, :conditions => "status = 'approved'")
    # @fund = Fund.find(:all, :conditions => "status = 'approved'")
    @fund = Fund.new
    @fund.size=nil
    if params[:id]
      @fund.manager_id=params[:id].to_i
    end
    if params[:newfund]
      @newfund = true
    end
  end

  def edit
    @managers = @managers = Manager.find(:all, :conditions => "status = 'approved'")
    @fund = Fund.find(params[:id])
  end

  
 

  def create
    @fund = Fund.new(params[:fund])
    @fund.creator = current_user
    @fund.updater = current_user
    if current_user.has_role('Admin')
      @fund.admined = true
      @user = User.find_by_login(params[:fund][:user_login])
      if @user
        @fund.user_id=@user.id
      end
    else
      @fund.user_id=current_user.id
    end
    if @fund.save
      flash[:notice] = 'Fund was successfully created.'
      redirect_to "/classified_funds"
    else
      @managers = Manager.find(:all, :conditions => "status = 'approved'")
      render :action => "new"
    end
  end

  def update
    @fund = Fund.find(params[:id])
    @fund.updater = current_user
    if @fund.update_attributes(params[:fund])
      flash[:notice] = 'Fund was successfully updated.'
      redirect_to :funds
    else
      @managers = @managers = Manager.find(:all, :conditions => "status = 'approved'")
      render :action => "edit"
    end
  end

  

  def destroy
    @fund = Fund.find(params[:id])
    if has_access?(@fund)
      name = @fund.name+'_'+Date.today.strftime("%m/%d/%Y_%I:%M%p")
      @fund.update_attributes(:name => name,:status => 'deleted', :updated_at => Date.today, :updated_by => current_user.id)
      if params[:from_fund_details_page]
        flash[:notice] = 'Posting deleted successfully.'
        redirect_to :controller => "classified_funds", :action => "index"
      else
        flash[:notice] = 'Fund deleted successfully.'
        redirect_to(funds_url)
      end
    else
      render :text => "Sorry! You don't have enough privilege.", :layout => "main"
    end
  end

  def fund_report
    
  end

  def index
    conditions = "status = 'approved'"
    if !params[:id].blank?
      conditions += " manager_id = #{params[:id]}"
    elsif !current_user.has_role('Admin')
      conditions += " user_id = #{current_user.id}"
    end
    @funds = Fund.paginate :all, :page => params[:page], :per_page => 10, :conditions => conditions, :order => "created_at desc"
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end
  
  def deleted_funds
    @funds = Fund.paginate :page => params[:page], :per_page => 25, :conditions => {:status => "deleted"}, :order => "name"
    render :action => "index"
  end
  
  def approve_fund
    fund = Fund.find(params[:id])
    if fund
      fund.status = "approved"
      fund.approved_at=Date.today
      fund.approver_id=current_user.id
      fund.save
    end
    redirect_to :action => "deleted_funds"
  end

  def search
    @fund = nil;
    unless params[:fund][:name].blank?
      if params[:fund][:name].downcase=='search fund'
        redirect_to :action => 'index'
      else
        @fund = Fund.find(params[:fund][:name])
        if(!@fund.nil?)
          redirect_to :action => 'show', :id => @fund.id
        end
      end
    else
      @fund = Fund.find(:all,:conditions => {:status => "approved"})
      flash[:notice] = 'Please select a fund to view the details.'
      redirect_to :action => 'index'
    end
  end

  # Get funds/availability
  def check_funds
    manager = Manager.find_by_name(params[:manager_name])
    manager_id = manager.id if manager
    render :update do |page|
      if not manager_id
        page.replace_html 'fundscheck',  "Please choose a valid manager from drop down"
      elsif params[:fund_name].blank?
        page.replace_html 'fundscheck',  "Please enter the fund name"
      elsif Fund.find(:first, :conditions => {:manager_id =>  manager_id, :name => params[:fund_name]})
        page.replace_html 'fundscheck',  "Unavailable"
        page['fundscheck']['style']['color'] = 'red'
      else
        page.replace_html 'fundscheck',  "Available"
        page['fundscheck']['style']['color'] = 'green'
      end
      page['myHidden'].value = "#{manager_id}" if manager_id
    end
  end

end
