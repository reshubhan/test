class CurrenciesController < ApplicationController
  layout :currencies_layout
  access_control [:index, :new, :create, :update, :edit, :destroy] => 'admin'

  def currencies_layout
    if !current_user.blank? && current_user.has_role('Admin')
      'admin'
    else
      'main'
    end
  end
  
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end

  # GET /currencies/new
  # GET /currencies/new.xml
  def new
    @currency = Currency.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @currency }
    end
  end

  # GET /currencies/1/edit
  def edit
    @currency = Currency.find(params[:id])
  end

  # POST /currencies
  # POST /currencies.xml
  def create
    @currency = Currency.new(params[:currency])
    if @currency.save
      flash[:notice] = 'Currency was successfully created.'
      redirect_to(currencies_url)
    else
      render :action => "new"
    end
  end

  # PUT /currencies/1
  # PUT /currencies/1.xml
  def update
    @currency = Currency.find(params[:id])
    if @currency.update_attributes(params[:currency])
      flash[:notice] = 'Currency was successfully updated.'
      redirect_to(currencies_url)
    else
      render :action => "edit"
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.xml
  def destroy
    @currency = Currency.find(params[:id])
    @currency.destroy
    redirect_to(currencies_url)
  end
end
