class TickersController < ApplicationController

  before_filter :login_required

  layout :ticker_layout

  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'

  def ticker_layout
    if current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  # GET /tickers
  # GET /tickers.xml
  def index
    @tickers = Ticker.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickers }
    end
  end

  def show_ticker
    expire_page :controller => "main", :action => "index"
    ticker=Ticker.find_by_id(params[:id])
    ticker.update_attribute(:ticker_to_show, true)
    flash[:notice] = 'Ticker was Added to show ticker list.'
    redirect_to :action=>"index",:controller=>"tickers"
  end

  def remove_ticker
    expire_page :controller => "main", :action => "index"
    ticker=Ticker.find_by_id(params[:id])
    ticker.update_attribute(:ticker_to_show, false)
    flash[:notice] = 'Ticker was removed from the  show ticker  list.'
    redirect_to :action=>"index",:controller=>"tickers"
  end

  # GET /tickers/1
  # GET /tickers/1.xml
  def show
    @ticker = Ticker.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticker }
    end
  end

  # GET /tickers/new
  # GET /tickers/new.xml
  def new
    @ticker = Ticker.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticker }
    end
  end

  # GET /tickers/1/edit
  def edit
    @ticker = Ticker.find(params[:id])
  end

  # POST /tickers
  # POST /tickers.xml
  def create
    expire_page :controller => "main", :action => "index"
    @ticker = Ticker.new(params[:ticker])

    respond_to do |format|
      if @ticker.save
        flash[:notice] = 'Ticker was successfully created.'
        format.html { redirect_to(@ticker) }
        format.xml  { render :xml => @ticker, :status => :created, :location => @ticker }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tickers/1
  # PUT /tickers/1.xml
  def update
    expire_page :controller => "main", :action => "index"
    @ticker = Ticker.find(params[:id])

    respond_to do |format|
      if @ticker.update_attributes(params[:ticker])
        flash[:notice] = 'Ticker was successfully updated.'
        format.html { redirect_to(@ticker) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticker.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickers/1
  # DELETE /tickers/1.xml
  def destroy
    expire_page :controller => "main", :action => "index"
    @ticker = Ticker.find(params[:id])
    @ticker.destroy

    respond_to do |format|
      format.html { redirect_to(tickers_url) }
      format.xml  { head :ok }
    end
  end
end
