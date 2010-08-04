# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def is_admin?
    (current_user && current_user.has_role('Admin')) ? true : false
  end

   def automatic_description_for_all_types(type,id)
    if type=="postings"
      posttype=ClassifiedFund.find_by_id(id)
    end
    if type=="company"
      posttype=Company.find_by_id(id)
    end
    if type=="secondary"
      posttype=Secondary.find_by_id(id)
    end
    if type=="postings"
      if !posttype.nil? && !posttype.user.nil? && !posttype.user.plan.blank? && !posttype.user.profile.organization_type.nil?
        name = posttype.user.profile.organization_type.name
      else if !posttype.nil? && !posttype.user.nil? && !posttype.user.plan.blank?
          name=posttype.user.plan.role.title
        end
      end
    else
      user=User.find_by_id(posttype.user_id)
      name=user.plan.role.title
    end
    if posttype.description.blank?
      if type!= "secondary"
        if posttype.desired_size
          des_size=posttype.desired_size.name
        else
          des_size="Any"
        end

        if posttype.asset_id
          asset=Asset.find_by_id(posttype.asset_id).name
        else
          asset="Any"
        end
        if posttype.asset_type_id
          asset_type=Asset.find_by_id(posttype.asset_type_id).name
        else
          asset_type="Any"
        end
      end
      if type!= "secondary" && type!= "company"
        if posttype.fund_size
          fundsize=posttype.fund_size
        else
          fundsize="Any"
        end
      end
      if type!= "secondary"
        if posttype.geography_id
          geo=Geography.find(posttype.geography_id).name
        else
          geo="Any"
        end
      end
      if type=="company"
        des=name +" is looking to invest "+des_size+" in "+ asset_type.to_s+"&nbsp;"+asset.to_s+" focused on "+ geo.to_s
      end
      if type=="secondary"
        des=name +" is looking to invest "+" with net asset value as "+posttype.net_asset_value.name+" with expected price as "+posttype.expected_price
      end
      if type=="postings"
        des=name +" is looking to invest "+des_size+" in "+"&nbsp;"+asset.to_s+" with fund size "+fundsize+" focused on "+ geo.to_s+"."
      end
      return des
    else
      des=posttype.description
    end
  end
  
  def get_section(controller,action)
    case controller
    when "assets"
      return 2
    when "adverts"
      return 3
    when "attributes"
      return 4
    when "funds"
      return 5
    when "geographies"
      return 6
    when "managers"
      return 7
    when "comments"
      return 7
    when "secondaries"
      return 8
    when "classified_funds"
      return 9
    when "admin"
      if action=="upload"
        return 11
      elsif action=="users"
        return 1
      elsif action=="active_users"
        return 1
      elsif action=="manager_updates"
        return 7
      else
        return 1
      end
    when "pages"
      return 10
    when "currencies"
      return 12
    when "sectors"
      return 13
    when "companies"
      return 14
    when "organization_types"
      return 15
    when "webminars"
      return 16
    when "tickers"
      return 17
    when "statistics"
      return 18
    when "questions"
      return 19
    when "transaction_types"
      return 20
    when "notifications"
      return 21
    else
      return 1
    end
  end

  def get_frequency_value(id,notification_email)
    notification_email["#{id}"]
  end

  def get_currency(currency)
    case currency
    when 1
      return 'USD'
    when 2
      return 'GBP'
    when 3
      return 'EUR'
    when 4
      return 'CHF'
    when 5
      return 'CAD'
    end
  end

  def is_a_number(s)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
  
  def get_bar_width(max,total,value)
    max_width = number_with_precision((max*100.0)/total, 1)
    value_width = number_with_precision((value*100.0)/total, 1)
    width = number_with_precision((value_width.to_f*100.0)/max_width.to_f,1)
    width
  end

  def set_transaction_type(asset_id,transaction_type)
    asset=Asset.find(asset_id)
    if asset.name=="Distressed" && (transaction_type.transaction_type=="Company")
      true
    elsif asset.name=="Real Estate" && (transaction_type.transaction_type=="Core-Plus" ||transaction_type.transaction_type=="Hotels")
      true
    elsif asset.name=="Buyout"
      true
    elsif asset.name=="Growth Capital" || asset.name=="Venture Capital"
      true
    else
      false
    end
  end

  def wrap_long_string(text,max_width = 16)
    (text.length < max_width) ? text : (text.scan(/.{1,#{max_width}}/).join('<wbr>'))
  end

  def wrap_price_string(text)
    (text.include? '(') ? (text.sub('(', '<br/>(')) : text
  end

  def wrap_string(text,max_width = 20)
    (text.length < max_width) ? text : text[0..max_width]+"..."
  end

#  def number_to_currency(number, options = {})
#    options   = options.stringify_keys
#    precision = 0 #options["precision"] || 2
#    unit      = options["unit"] || "$"
#    separator = precision > 0 ? options["separator"] || "." : ""
#    delimiter = options["delimiter"] || ","
#    format    = options["format"] || "%u%n"
#
#    begin
#      parts = number_with_precision(number, precision).split('.')
#      format.gsub(/%n/, number_with_delimiter(parts[0], delimiter) + separator + parts[1].to_s).gsub(/%u/, unit)
#    rescue
#      number
#    end
#  end

  def get_asset_types(options,type)
    @assets = []
    if type.eql? "company"
      if options.size == 1
        @assets = Asset.find(:all, :conditions => ["parent_id is null and id = ?", options])
      else
        @assets = Asset.find(:all, :conditions => "id in ('#{options.join("','")}') and parent_id is null")
      end
    elsif type.eql? "fund"
      asset=Asset.find(options)
      case (asset.name)
      when "Hedge Funds"
        @assets.push(Asset.find(:first,:conditions =>"name in ('Hedge Funds')"))
      when "Real Estate"
        @assets=Asset.find(:all,:conditions => "name in ('Natural Resources','Infrastructure','Real Estate')").reverse
      when "Private Equity"
        @assets = Asset.find(:all,:conditions => "name not in ('Private Equity','Natural Resources','Infrastructure','Real Assets','Real Estate','Hedge Funds','Credit') and parent_id is null")
        @assets.push(Asset.find(:first,:conditions => "name='Private Equity' and parent_id is null"))
        @assets = @assets.reverse
      end
    end
    return @assets
  end

  def display_name(name)
    case name
    when 'Real Estate'
      return 'Real Assets'
    when 'Venture Capital'
      return 'Venture & Growth'
    else
      return name
    end
  end
end
