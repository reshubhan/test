class AttributesController < ApplicationController
  layout "admin"
  access_control [:index, :new, :show, :create, :update, :edit, :destroy] => 'admin'
  
  # GET /attributes
  def index
    @attributes = Attribute.paginate :order => 'name', :page => params[:page], :per_page => 25
    if request.xhr?
      render(:update) do |page|
        page.replace_html 'results', :partial => "results"
      end
    end
  end

  # GET /attributes/1
  def show
    @attribute = Attribute.find(params[:id])
  end

  # GET /attributes/new
  def new
    @attribute = Attribute.new
  end

  # GET /attributes/1/edit
  def edit
    @attribute = Attribute.find(params[:id])
    @asset_attributes = AssetAttribute.find_all_by_attribute_id(params[:id])
  end

  # POST /attributes
  def create
    @attribute = Attribute.new(params[:attribute])
    @attribute.creator = current_user
    @attribute.updater = current_user
    if @attribute.save
      for i in params[:asset_list]
        AssetAttribute.create(:asset_id => i, :attribute_id => @attribute.id, :attribute_type => params["type_" + i])
      end
      flash[:notice] = 'Attribute was successfully created.'
      redirect_to(@attribute)
    else
      render :action => "new"
    end
  end

  # PUT /attributes/1
  def update
    @attribute = Attribute.find(params[:id])
    @attribute.updater = current_user
    if @attribute.update_attributes(params[:attribute])
      asset_attribute_list = AssetAttribute.find_all_by_attribute_id(@attribute.id)
      for aa in asset_attribute_list
        aa.destroy
      end
      for i in params[:asset_list]
        AssetAttribute.create(:asset_id => i, :attribute_id => @attribute.id, :attribute_type => params["type_" + i])
      end
      flash[:notice] = 'Attribute was successfully updated.'
      redirect_to(attributes_url)
    else
      render :action => "edit"
    end
  end

  # DELETE /attributes/1
  def destroy
    @attribute = Attribute.find(params[:id])
    @attribute.destroy
    redirect_to(attributes_url)
  end
  
  protected

  def permission_denied
    flash[:notice] = "You don't have privileges to access this action"
    return redirect_back_or_default('/')
  end
end
