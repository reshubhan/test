class MainController < ApplicationController
  auto_complete_for :manager, :name, :limit => 15
  caches_page :index
  
  def index
    if current_user
      unless current_user.has_role('Admin')
        redirect_to :controller => 'classified_funds', :action => 'index'
      else
        redirect_to :controller => 'admin', :action => 'index'
      end
    end
  end

  def select_user_type
    
  end
  
  def select_plan
    if current_user
      redirect_to "/"
    end
    @role = Role.find(params[:role_id])
  end
  
  def landing_page
    @title = "welcome " + current_user.profile.firstname
  end

  def list_managers
    if params[:search]
      @managers = Manager.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def self.getName(model, id, params)
    manager_name = false
    if model == "managers"
      object = Manager.find(id)
    elsif model == "secondaries"
      object = Secondary.find(id)
      manager_name = true
    elsif model == "funds"
      object = Fund.find(id)
    elsif model == "classified_funds"
      object = ClassifiedFund.find(id)
      if object.classified_fund_type=='buy'
        return "New fund to buy"
      else
        return "New fund to sell"
      end
    elsif model == "companies"
      object = Company.find(id)
      if not object.blank? and object.company_type=="sell"
        return "Direct/Co-investement to sell"
      else
        return "Direct/Co-investement to buy"
      end
    elsif model == "assets"
      object = Asset.find(id)
    elsif model == "attributes"
      object = Attribute.find(id)
    elsif model == "geographies"
      object = Geography.find(id)
    elsif model == "sectors"
      object = Sector.find(id)
    elsif model == "pages"
      object = Page.find(id)
    elsif model == "currencies"
      object = Currency.find(id)
    end
    if manager_name
      object.blank? ? id : object.manager.name
    else
      object.blank? ? id : object.name
    end
  end
end
