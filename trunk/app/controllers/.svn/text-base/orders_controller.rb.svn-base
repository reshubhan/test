class OrdersController < ApplicationController
  layout 'main'
  # GET /orders
  # GET /orders.xml

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @user = User.find(params[:id])
    @order = Order.new
    @order.user = @user
    @order.first_name = @user.profile.firstname
    @order.last_name = @user.profile.lastname
    if params[:companyIdToSell]
      @order.amount = 29 # Basic user to pay $29 when posting a company to sell
      @companyIdToSell = params[:companyIdToSell]
    else
      if params[:upgrade]
        @order.order_type = "membership_upgrade"
        if params[:plan_id]
          @order.plan = Plan.find(params[:plan_id])
        else
          @order.plan = Plan.membership_plan(params[:upgrade_plan][:plan_type],@user) #new plan received not the current plan
          if @order.plan.duration=="1 month"
            @user.end_date=@user.start_date.to_date>>(1)
          elsif @order.plan.duration=="14 month"
            @user.end_date=@user.start_date.to_date>>(14)
          end
          @user.save
        end
        if @order.plan.fee<0
          flash[:notice]="Please contact Trusted Insight for fee payment."
          redirect_to "/"
        else
          @order.amount = @order.plan.fee
        end
      else
        @order.order_type = "sign_up"
        @order.plan = @user.plan
        if @order.plan.fee<0
          flash[:notice]="Please contact Trusted Insight for fee payment."
          redirect_to "/"
        else
          @order.amount = @user.plan.fee
        end
      end
    end
  end


  # POST /orders
  # POST /orders.xml
  
  def confirm
    @order = Order.new(params[:order])
    session[:order]= params[:order]
    @companyIdToSell = params[:companyIdToSell] if params[:companyIdToSell] 
    @user = User.find(current_user.id)
    unless @order.valid?
      render :action => 'new'
    end
#    flash[:notice] = "Card information invalid!!"
  end
  
  def create
    @order = Order.new(session[:order])
      
    @order.ip_address = request.remote_ip
    @companyIdToSell = params[:companyIdToSell] if params[:companyIdToSell]
    @user = User.find_by_id(@order.user_id)
    if @order.save
      if params[:companyIdTosell].blank?
        payment_type=@order.order_type
      else
        payment_type="company_to_sell"
      end
      if @order.purchase(@user,payment_type)
        if not @companyIdToSell.blank?
          flash[:notice] = ' Payment made successful, You can now create a Direct/Co-Investestment to sell'
        else
          user = User.find(@order.user_id)
          if @order.order_type == "membership_upgrade"
            user.update_attributes(:plan_id => @order.plan_id, :emails => @order.plan.no_of_emails, :views => @order.plan.no_of_views, :replies => @order.plan.no_of_replies)
          end
          user.update_attribute(:paid, true)
          if @order.order_type == "sign_up"
            url = 'http://' + request.env["HTTP_HOST"]+'/activate/' + @order.user.activation_code
            Mailer.deliver_account_activation_mail(@order.user, url)
          end          
        end
        Mailer.deliver_payment_receipt_mail(@order)
        flash[:notice] = 'Payment made successfully, A mail has been sent to your account.'
        redirect_to :action => "success", :id => @order.id
      else
        render :action => "failure" 
      end
    else
      @user = User.find(@order.user_id)
      render :action => 'new'
    end
  end


  # PUT /orders/1
  # PUT /orders/1.xml
  

  # DELETE /orders/1
  # DELETE /orders/1.xml
 

  def success
    @tran = OrderTransaction.find(:last, :conditions => "order_id = #{params[:id]}")
    @order = Order.find(params[:id])
  end

  

  private

  def index
    @orders = Order.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end
 
  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        flash[:notice] = 'Order was successfully updated.'
        format.html { redirect_to(@order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end
end
