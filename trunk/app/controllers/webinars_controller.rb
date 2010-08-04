class WebinarsController < ApplicationController

  before_filter :login_required

  layout :webinars_layout

  access_control [:new, :create, :update, :edit, :destroy] => 'admin'

  def webinars_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end

  # GET /webinars
  # GET /webinars.xml
  def index
    @webinars = Webinar.paginate :order => 'date desc', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /webinars/1
  # GET /webinars/1.xml
  def show
    @webinar = Webinar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @webinar }
    end
  end

  # GET /webinars/new
  # GET /webinars/new.xml
  def new
    @webinar = Webinar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @webinar }
    end
  end

  # GET /webinars/1/edit
  def edit
    @webinar = Webinar.find(params[:id])
  end

  # POST /webinars
  # POST /webinars.xml
  def create
    @webinar = Webinar.new(params[:webinar])

    respond_to do |format|
      if @webinar.save
        flash[:notice] = 'Webinar was successfully created.'
        format.html { redirect_to(@webinar) }
        format.xml  { render :xml => @webinar, :status => :created, :location => @webinar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @webinar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /webinars/1
  # PUT /webinars/1.xml
  def update
    @webinar = Webinar.find(params[:id])

    respond_to do |format|
      if @webinar.update_attributes(params[:webinar])
        flash[:notice] = 'Webinar was successfully updated.'
        format.html { redirect_to(@webinar) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @webinar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /webinars/1
  # DELETE /webinars/1.xml
  def destroy
    @webinar = Webinar.find(params[:id])
    @webinar.destroy

    respond_to do |format|
      format.html { redirect_to(webinars_url) }
      format.xml  { head :ok }
    end
  end
end
