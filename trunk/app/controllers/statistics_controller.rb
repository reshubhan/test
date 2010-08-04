class StatisticsController < ApplicationController

  before_filter :login_required

  layout :statistic_layout

  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'

  def statistic_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  # GET /statistics
  # GET /statistics.xml
  def index
    @statistics = Statistic.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statistics }
    end
  end

  def show_statistic
    expire_page :controller => "main", :action => "index"
    statistic=Statistic.find_by_id(params[:id])
    statistic.update_attribute(:statistic_to_show, true)
    flash[:notice] = 'Statistic was Added to show statistic list.'
    redirect_to :action=>"index",:controller=>"statistics"
  end

  def remove_statistic
    expire_page :controller => "main", :action => "index"
    statistic=Statistic.find_by_id(params[:id])
    statistic.update_attribute(:statistic_to_show, false)
    flash[:notice] = 'Statistic was removed from the  show statistic  list.'
    redirect_to :action=>"index",:controller=>"statistics"
  end

  # GET /statistics/1
  # GET /statistics/1.xml
  def show
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @statistic }
    end
  end

  # GET /statistics/new
  # GET /statistics/new.xml
  def new
    @statistic = Statistic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @statistic }
    end
  end

  # GET /statistics/1/edit
  def edit
    @statistic = Statistic.find(params[:id])
  end

  # POST /statistics
  # POST /statistics.xml
  def create
    expire_page :controller => "main", :action => "index"
    @statistic = Statistic.new(params[:statistic])

    respond_to do |format|
      if @statistic.save
        flash[:notice] = 'Statistic was successfully created.'
        format.html { redirect_to(@statistic) }
        format.xml  { render :xml => @statistic, :status => :created, :location => @statistic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statistics/1
  # PUT /statistics/1.xml
  def update
    expire_page :controller => "main", :action => "index"
    @statistic = Statistic.find(params[:id])

    respond_to do |format|
      if @statistic.update_attributes(params[:statistic])
        flash[:notice] = 'Statistic was successfully updated.'
        format.html { redirect_to(@statistic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @statistic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.xml
  def destroy
    expire_page :controller => "main", :action => "index"
    @statistic = Statistic.find(params[:id])
    @statistic.destroy

    respond_to do |format|
      format.html { redirect_to(statistics_url) }
      format.xml  { head :ok }
    end
  end
end
