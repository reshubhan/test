class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  has_many :transactions, :class_name => "OrderTransaction"

  attr_accessor :card_number, :card_verification

  validate_on_create :validate_card

  def card
    if card_type=='visa'
      "Visa"
    end
    if card_type=='discover'
      "Discover"
    end
    if card_type=='american_express'
      "AmericanExpress"
    end
    if card_type=='master'
      "MasterCard"
    end
  end

  def card_month
    card_expires_on.month.to_s.length==1 ? "0#{card_expires_on.month.to_s}" : card_expires_on.month.to_s
  end

  def card_year
    card_expires_on.year.to_s
  end

  def purchase(user,payment_type)
    if payment_type=="sign_up"
      description = user.id.to_s+","+id.to_s+","+payment_type+","+user.fullname+","+user.profile.organization_type.name+","+user.plan.name+","+user.plan.role.title
    else
      description = user.id.to_s+","+id.to_s+","+payment_type+","+user.plan.name+","+user.plan.role.title
    end
    credit_card = Hash.new
    credit_card[:type] = card
    credit_card[:number] = card_number.to_s
    credit_card[:exp_month] = card_month
    credit_card[:exp_year] = card_year
    credit_card[:cvv2] = card_verification.to_s
    credit_card[:card_owner] = user.fullname
    if payment_type=="company_to_sell"
      description = user.id.to_s+","+id.to_s+","+payment_type+","+user.plan.name+","+user.plan.role.title
      if user.end_date!=Date.today
        response = JUST_PAY_GATEWAY.purchase(price_in_cents, credit_card_info, purchase_options(description))
      end
    else
      if plan.duration=="One Year"||plan.duration=="Two Year"
        if plan.duration=="One Year"
          response = GATEWAY.create_profile(nil, :credit_card => credit_card, :description => description, :start_date => Date.today+1, :frequency => 1,:period=>"Year", :amount => amount, :auto_bill_outstanding => true)
        end
        if  plan.duration=="Two Year"
          response = GATEWAY.create_profile(nil, :credit_card => credit_card, :description => description, :start_date => Date.today+1, :frequency => 2,:period=>"Year", :amount => amount, :auto_bill_outstanding => true)
        end
      end
      if plan.duration=="12 months"||plan.duration=="1 month" ||plan.duration=="14 month"
        if plan.duration=="12 months"
          response = GATEWAY.create_profile(nil, :credit_card => credit_card, :description => description, :start_date => Date.today+1, :frequency => 12, :amount => amount, :auto_bill_outstanding => true)
        end
        if  plan.duration=="1 month"
          response = GATEWAY.create_profile(nil, :credit_card => credit_card, :description => description, :start_date => Date.today+1, :frequency => 1, :amount => amount, :auto_bill_outstanding => true)
        end
        if  plan.duration=="14 month"
          response = GATEWAY.create_profile(nil, :credit_card => credit_card, :description => description, :start_date => Date.today+1, :frequency => 14, :amount => amount, :auto_bill_outstanding => true)
        end
      end
    end
    # Save this profile_id in your transactions table.  This is used to cancel/modify the plan in the future.
    profile_id = response.params["profile_id"] if response.params["profile_id"]
    @usernew = User.find(user.id)
    @usernew.update_attribute("paypal_profile_id", profile_id) if profile_id
    if response.success?
      true
    else
      false
    end
  end

  def price_in_cents
    (amount*100).round
  end

  private

  def purchase_options(desc)
    {
      :ip => ip_address,
      :description => desc,
      :billing_address => {
        :name     => "trustedinsight",
        :address1 => "address1",
        :city     => "NY",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end

  def validate_card
    unless credit_card_info.valid?
      credit_card_info.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end

  def credit_card_info
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

end
