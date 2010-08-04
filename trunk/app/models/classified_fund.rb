class ClassifiedFund < ActiveRecord::Base
  attr_accessor             :user_login
  attr_accessor             :not_new_fund_buy
  attr_accessor             :manager_name
  attr_accessor             :admined
  validates_presence_of     :manager_name, :if => :type_sell
  validates_presence_of     :fund_id, :if => :type_sell
  validates_presence_of     :user_login, :message => "name is required", :if => :admined
  validate :custom_message, :if => :not_new_fund_buy


  DESIRED_SIZE = ['$5M-20M','<$5M','$20-50M', '$50-100M', '>$100M']
  FUND_SIZE = ['<$100M', '$100M-250M', '$250M-500M', '$500M-1B', '$1B-$5B', '>$5B']

  belongs_to :manager
  belongs_to :user, :class_name => 'User', :foreign_key =>'user_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  belongs_to :fund, :class_name => 'Fund', :foreign_key => 'fund_id'
  belongs_to :desired_size
  has_and_belongs_to_many :sectors, :uniq => true
  belongs_to :geography
  belongs_to :asset
  has_many :companies

  def custom_message
    errors.add_to_base("Asset can't be blank.") if asset_id.blank? and classified_fund_type == 'buy'
    errors.add_to_base("Description can't be blank.") if description.blank?
  end

  def user_login
    user.login if user
  end

  def user_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end

  def type_buy
    self.classified_fund_type == 'buy'? true : false
  end

  def automated_generated_description(id)
    classified_fund=ClassifiedFund.find_by_id(id)
    user='user'
    if !classified_fund.nil? && !classified_fund.user.nil? && !classified_fund.user.plan.blank? && !classified_fund.user.profile.organization_type.nil?
      user = classified_fund.user.profile.organization_type.name
    elsif !classified_fund.nil? && !classified_fund.user.nil? && !classified_fund.user.plan.blank?
      user=classified_fund.user.plan.role.title
    end
    if classified_fund.desired_size
      des_size=classified_fund.desired_size.name
    else
      des_size="Any"
    end
    if classified_fund.asset_id
      asset=Asset.find_by_id(asset_id).name
    else
      asset="Any"
    end
    if classified_fund.asset_type_id
      asset_type=Asset.find_by_id(asset_type_id).name
    else
      asset_type="Any"
    end
    if classified_fund.fund_size
      fundsize=classified_fund.fund_size
    else
      fundsize="Any"
    end
    if classified_fund.geography_id
      geo=Geography.find_by_id(geography_id).name
    else
      geo="Any"
    end
    des=user+" is looking to invest "+des_size+" in "+ asset_type.to_s+"&nbsp;"+asset.to_s+" with fund size "+fundsize+" focused on "+ geo.to_s
  end

  def type_sell
    self.classified_fund_type == 'sell' ? true : false
  end
   
  def self.total_desired_size
    ClassifiedFund.sum(:all, :joins => "inner join desired_sizes d on d.id = classified_funds.desired_size_id", :conditions => "status='approved'", :select => "d.size_in_billions")
  end
  
  def self.paginate_results( params, orderby = nil, ascdesc = nil, page = 1)
    sort = ascdesc.blank? ? 'desc' : ascdesc
    type = params[:type].blank? ? 'buy' : params[:type]
    if type=="sell"
      joins = "inner join users u on u.id = classified_funds.user_id LEFT OUTER JOIN desired_sizes d on d.id = classified_funds.desired_size_id"
    else
      joins = "inner join users u on u.id = classified_funds.user_id INNER JOIN desired_sizes d on d.id = classified_funds.desired_size_id"
    end
    conditions = "classified_funds.classified_fund_type = '#{type}' AND classified_funds.status='approved' AND u.status ='approved'"
    order = ""
    if params[:institution] && params[:institution] != 'Any'
      joins += " inner join profiles p on p.user_id = u.id"
      conditions += " AND p.organization_type_id = #{params[:institution]}"
    end
    if params[:type]=='sell'
      joins += " inner join managers m on m.id = classified_funds.manager_id"
      if params[:geography] && params[:geography] != 'Any'
        conditions += " AND m.geography_id = #{params[:geography]}"
      end
      if params[:asset_class] &&  params[:asset_class] != 'Any'
        conditions += " AND m.asset_primary_id = #{params[:asset_class]}"
      end
      if params[:asset_type] &&  params[:asset_type] != 'Any'
        conditions += " AND m.asset_secondary_id = #{params[:asset_type]}"
      end
      if params[:fund_size] && params[:fund_size] != 'Any Size'
        joins += " inner join funds f on f.id = classified_funds.fund_id"
        conditions += ClassifiedFund.get_fund_sub_query(params[:fund_size])
      end
      if orderby=='newfund'
        order = "m.name #{sort}, "
      elsif orderby=='url'
        order = "m.url #{sort}, "
      elsif orderby=='fundname'
        joins += " inner join funds f on f.id = classified_funds.fund_id"
        order = "f.name #{sort}, "
      elsif orderby=='Description'
        order = "classifies_funds.description #{sort}, "
      end
    else
      if params[:geography] && params[:geography] != 'Any'
        conditions += " AND classified_funds.geography_id = #{params[:geography]}"
      end
      if params[:asset_class] &&  params[:asset_class] != 'Any'
        conditions += " AND classified_funds.asset_id = #{params[:asset_class]}"
      end
      if params[:asset_type] &&  params[:asset_type] != 'Any'
        conditions += " AND classified_funds.asset_type_id = #{params[:asset_type]}"
      end
      if params[:desired_size] && params[:desired_size] != 'Any Size'
        conditions += " AND d.name = '#{params[:desired_size]}'"
      end
      if params[:fund_size] && params[:fund_size] != 'Any Size'
        conditions += " AND classified_funds.fund_size = '#{params[:fund_size]}'"
      end
      if orderby=='newfund'
        joins += " left outer join roles_users ur on ur.user_id = u.id inner join roles r on r.id = ur.role_id"
        order = "r.title #{sort}, "
      elsif orderby=='asset'
        joins += " left outer join assets ast on ast.id = classified_funds.asset_id"
        order = "ast.name #{sort}, "
      elsif orderby=='assettype'
        joins += " left outer join assets ast on ast.id = classified_funds.asset_type_id"
        order = "ast.name #{sort}, "
      elsif orderby=='sector'
        joins += " left outer join sectors s on s.id = classified_funds.sector_id "
        order = "s.name #{sort}, "
      elsif orderby=='geography'
        joins += " left outer join geographies g on g.id = classified_funds.geography_id "
        order = "g.name #{sort}, "
      elsif orderby=='fund_size'
        order = "classified_funds.fund_size #{sort}, "
      elsif orderby=='desired_size'
        order = "d.name #{sort}, "
      end
    end
    order += "classified_funds.id desc "
    
    amount_total= ClassifiedFund.sum(:all, :joins => joins, :conditions => conditions, :select => "d.size_in_billions")
    classified_funds = ClassifiedFund.paginate(:all, :joins => joins, :conditions => conditions, :order => order, :page => page, :per_page => 10, :select => "classified_funds.*")
    total = ClassifiedFund.count(:all, :joins => joins, :conditions => conditions)
    return classified_funds, total, amount_total
  end

  def self.profile_results(page,user,type)
    conditions ="user_id =#{user} and classified_fund_type='#{type}' and status='approved'"
    ClassifiedFund.paginate(:all,:conditions => conditions,:page => page,:per_page =>5,:select => "classified_funds.*")
  end
  def self.get_fund_sub_query(fund_size)
    case fund_size
    when '<$100M'
      subquery = " AND f.size < 100"
    when '$100M-250M'
      subquery = " AND f.size BETWEEN 100 AND 250"
    when '$250M-500M'
      subquery = " AND f.size BETWEEN 250 AND 500"
    when '$500M-1B'
      subquery = " AND f.size BETWEEN 500 AND 1000"
    when '$1B-$5B'
      subquery = " AND f.size BETWEEN 1000 AND 5000"
    when '>$5B'
      subquery = " AND f.size > 5000"
    end
    subquery
  end

  def manager_name
    manager.name if manager
  end

  def manager_name=(name)
    self.manager = Manager.find_by_name(name) unless name.blank?
  end

  def self.getheading(params)
    if params[:type].eql?'sell'
      heading = "New Funds to sell"
    else
      heading = "Institutional Investors looking for new funds to buy"
    end
#    search_parameters = 0
    if params[:asset_class] && params[:asset_class] != 'Any'
      heading += " #{Asset.find(params[:asset_class]).name}"
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Asset.find(params[:asset_class]).name} Asset class"
#      search_parameters += 1
    end

#    if params[:asset_type] && params[:asset_type] != 'Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Asset.find(params[:asset_type]).name} Asset type"
#      search_parameters += 1
#    end
#
#    if params[:geography] && params[:geography] != 'Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Geography.find(params[:geography]).name} Geography"
#      search_parameters += 1
#    end
#
#    if params[:institution] && params[:institution] != 'Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{OrganizationType.find(params[:institution]).name} Institution type"
#      search_parameters += 1
#    end
#
#    if params[:desired_size] && params[:desired_size] != 'Any Size'
#      heading += "#{(search_parameters == 0)? '' : ', '}Desired size #{params[:desired_size]}"
#      search_parameters += 1
#    end
#
#    if params[:fund_size] && params[:fund_size] != 'Any Size'
#      heading += "#{(search_parameters == 0)? '' : ', '}Fund size #{params[:fund_size]}"
#      search_parameters += 1
#    end
#
#    return (search_parameters == 0)? heading.gsub(' for ', '') : heading
    heading
  end

end
