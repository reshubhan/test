class AdvertsController < ApplicationController
  layout "admin"
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'
  
  # GET /adverts
  # GET /adverts.xml
  def index
    @adverts = Advert.paginate :conditions=>"parent_id is null", :order => 'name', :page => params[:page], :per_page => 25
    
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /adverts/1
  # GET /adverts/1.xml
  def show
    @advert = Advert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advert }
    end
  end

  # GET /adverts/new
  # GET /adverts/new.xml
  def new
    @advert = Advert.new
  end

  def create
    @advert = Advert.new(params[:advert])
    if params[:advert][:name].blank?
      @advert.name = "ad_"+rand(1000000).to_s
    else
      @advert.name = params[:advert][:name]
    end
    if params[:advert][:link].blank?
      @advert.link = "#"
    else
      @advert.link = params[:advert][:link]
    end
    if @advert.save
      redirect_to(adverts_path)
    else
      render :action => :new
    end
  end


  # GET /adverts/1/edit
  def edit
    @advert = Advert.find(params[:id])
  end


  # PUT /adverts/1
  # PUT /adverts/1.xml
  def update
    @advert = Advert.find(params[:id])

    respond_to do |format|
      if @advert.update_attributes(params[:advert])
        format.html { redirect_to(adverts_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverts/1
  # DELETE /adverts/1.xml
  def destroy
    @advert = Advert.find(params[:id])
    @advert.destroy

    respond_to do |format|
      format.html { redirect_to(adverts_url) }
      format.xml  { head :ok }
    end
  end
end
