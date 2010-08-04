class GeographiesController < ApplicationController
  layout "admin"
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'
  
  # GET /geographies
  def index
    @geographies = Geography.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end
  
  def geography_images
    @geographies = Geography.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "image_results"
      end
    end
  end

  # GET /geographies/new
  def new
    @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
    @geography = Geography.new
  end

  # GET /geographies/1/edit
  def edit
    @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
    @geography = Geography.find(params[:id])
  end
  def edit_image
    @geography = Geography.find(params[:id])
  end

  
  def upload_image
    @geography=Geography.find_by_id(params[:geography])
    @geography.image_file_name=params[:image][:file]
    @geography.save
    flash[:notice] = 'Image was successfully Uploaded.'
    redirect_to :action=>"geography_images"
  end

  # POST /geographies
  def create
    @geography = Geography.new(params[:geography])
    @geography.creator = current_user
    @geography.updater = current_user
    if @geography.save
      flash[:notice] = 'Geography was successfully created.'
      redirect_to(geographies_url)
    else
      @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
      render :action => "new"
    end
  end

  # PUT /geographies/1
  def update
    @geography = Geography.find_by_name(params[:geography][:name])
    @geography.updater = current_user
    if @geography.update_attributes(params[:geography])
      if not params[:geography][:advert_ids]
        @geography.adverts.clear
        @geography.save
      end
      flash[:notice] = 'Geography was successfully updated.'
      redirect_to(geographies_url)
    else
      @adverts = Advert.find(:all, :conditions => "parent_id is NULL")
      render :action => "edit"
    end
    
  end

  # DELETE /geographies/1
  def destroy
    @geography = Geography.find(params[:id])
    @geography.destroy
    redirect_to(geographies_url)
  end

  def remove_ad
    geography = Geography.find(params[:id])
    if geography
      geography.image=nil
      geography.save
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