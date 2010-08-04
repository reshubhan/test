class AssetsController < ApplicationController
  layout "admin"
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'
  
  # GET /assets
  def index
    @assets = Asset.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /assets/new
  def new
    @asset = Asset.new
    @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
    if params[:id]
      @asset_type = true
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
    unless @asset.sponsered.nil?
      manager_id= @asset.sponsered.split(",").compact.collect{|x| x.to_i}
      if manager_id.length==1
        temp=Manager.find_by_id(manager_id)
        @sponsered_managers= Array.new(1)
        @sponsered_managers[0]=temp
      else
        @sponsered_managers= Manager.find_all_by_id(manager_id)
      end
    end
    @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
    if @asset.parent_id
      @asset_type = true
    end
  end

  # POST /assets
  def create
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>"+params.inspect
    @asset = Asset.new(params[:asset])
    @asset.creator = current_user
    @asset.updater = current_user
    unless params[:manager].nil?
      managers= params[:manager].values.join(",")
      @asset.sponsered= managers
    end
    if @asset.save
      if @asset.has_parent
        flash[:notice] = 'Asset Type was successfully created.'
        flash[:asset_type] = 'asset_type'
        redirect_to(assets_url)
      else
        flash[:notice] = 'Asset was successfully created.'
        redirect_to(assets_url)
      end
    else
      if @asset.parent_id
        @asset_type = true
      end
      @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
      render :action => "new"
    end
  end

  # PUT /assets/1
  def update
    @asset = Asset.find(params[:asset][:id])
    @asset.updater = current_user
    if @asset.update_attributes(params[:asset])
      if not params[:asset][:advert_ids]
        @asset.adverts.clear
        @asset.save
      end
      unless params[:manager].nil?
        managers= params[:manager].values.join(",")
        @asset.sponsered= managers
        @asset.save
      end
      if @asset.has_parent
        flash[:notice] = 'Asset Type was successfully updated.'
        flash[:asset_type] = 'asset_type'
        redirect_to(assets_url)
      else
        flash[:notice] = 'Asset was successfully updated.'
        redirect_to(assets_url)
      end
    else
      if @asset.parent_id
        @asset_type = true
      end
      @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
      render :action => "edit"
    end

  end

  def activate_asset
    Asset.find(params[:id]).update_attribute("active_asset", params[:inactivate] ? false : true)
    @assets = Asset.paginate :order => 'name', :page => params[:page], :per_page => 25
    render(:update) do |page|
      page.replace_html 'results', :partial => "results"
    end
  end

  def default_asset
    Asset.find(params[:id]).update_attribute(:default_asset, params[:remove_default] ? false : true)
    @assets = Asset.paginate :order => 'name', :page => params[:page], :per_page => 25
    render(:update) do |page|
      page.replace_html 'results', :partial => "results"
    end
  end

  # DELETE /assets/1
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
    redirect_to(assets_url)
  end

  def get_children
    if params[:asset_id]
      asset_types = Asset.get_children(params[:asset_id])
    end
    unless asset_types.blank?
      render :partial => "asset_types", :locals => {:asset => params[:asset_id].to_i, :object_type => params[:object_type]}
    else
      render :text => "<img src='/images/warning.gif'>This Asset does not have any Types associated with it!</p>"
    end
  end

  def remove_ad
    @asset = Asset.find(params[:id])
    if @asset
      @asset.image=nil
      @asset.save
      render(:update) do |page|
        page.replace_html 'ad_options', " "
      end
    end
  end
  
  protected

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action"
    return redirect_back_or_default('/')
  end
end
