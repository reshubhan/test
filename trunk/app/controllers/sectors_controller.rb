class SectorsController < ApplicationController
  layout :sectors_layout
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'

  def sectors_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  
  # GET /sectors
  # GET /sectors.xml
  def index
    @sectors = Sector.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /sectors/1
  # GET /sectors/1.xml
  def show
    @sector = Sector.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectors/new
  # GET /sectors/new.xml
  def new
    @sector = Sector.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sector }
    end
  end

  # GET /sectors/1/edit
  def edit
    @sector = Sector.find(params[:id])
  end

  # POST /sectors
  # POST /sectors.xml
  def create
    @sector = Sector.new(params[:sector])
    if @sector.save
      flash[:notice] = 'Sector was successfully created.'
      redirect_to(sectors_url)
    else
      render :action => "new"
    end
  end

  # PUT /sectors/1
  # PUT /sectors/1.xml
  def update
    @sector = Sector.find(params[:id])
    if @sector.update_attributes(params[:sector])
      flash[:notice] = 'Sector was successfully updated.'
      redirect_to(sectors_url)
    else
      render :action => "edit"
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.xml
  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy
    redirect_to(sectors_url)
  end
end
