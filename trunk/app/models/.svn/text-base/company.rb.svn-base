class Company < ActiveRecord::Base

  DESIRED_SIZE = ['<$5M','$5M-20M','$20M-50M','$50M-100M','>$100M']
  TARGET_REVENUE = ['<$5M','$5M-20M','$20M-50M','$50M-100M','>$100M','Pre-revenue']
  TARGET_EBITDA = ['<$5M','$5M-20M','$20M-50M','$50M-100M','>$100M','Negative']
  TYPE_OF_FINANCING = ['Equity','Debt','Mezzanine','Other']
  POSTED_BY = ['Sponsoring Fund','Management','Broker','Other']

  has_and_belongs_to_many :sectors
  belongs_to :asset
  belongs_to :user
  belongs_to :geography
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  belongs_to :desired_size
  attr_accessor             :user_login
  attr_accessor :admined
  attr_accessor :target_ebitda
  validates_presence_of :asset_id
  validates_presence_of     :user_login, :message => "name is required", :if => :admined
  #  validates_presence_of :revenue_per_year, :if => :type_sell
  #  validates_presence_of :new_financing, :if => :type_sell
  validates_presence_of :desired_size, :if => :type_sell
  validates_presence_of :desired_size, :if => :type_buy


  def user_login
    user.login if user
  end

  def user_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end
  
  def has_asset?(asset)
    if assets and assets.size>0
      assets.each do |a| return true if a.id == asset end
    end
    return false
  end

  def self.total_desired_size
    Company.sum(:all, :joins => "inner join desired_sizes d on d.id = companies.desired_size_id", :conditions => "status='approved'", :select => "d.size_in_billions")
  end
  
  def type_sell
    self.company_type == 'sell' ? true : false
  end

  def type_buy
    self.company_type == 'buy'? true : false
  end

  def get_sector_names
    names = []
    sectors.each { |sector| names << sector.name }
    names.join(', ')
  end

  def self.company_results( params, orderby = nil, ascdesc = nil, page = 1)

    sort = ascdesc.blank? ? 'desc' : ascdesc
    type = params[:type].blank? ? 'buy' : params[:type]
    joins = "inner join desired_sizes d on d.id = companies.desired_size_id"
    conditions = "status='approved' AND company_type= '#{type}'"
    order = ""
    #    query="select c.* from companies c "
    #    conditions = "  where status='approved' AND company_type= '#{params['type']}'"
    if params[:financing] && params[:financing] != 'Any'
      conditions += " AND type_of_financing = '#{params[:financing]}'"
    end
    if params[:geography] && params[:geography] != 'Any'
      conditions += " AND geography_id = '#{params[:geography]}'"
    end
    if params[:desired_size] &&  params[:desired_size] != 'Any Size'
      conditions += " AND d.name = '#{params[:desired_size]}'"
    end
    if params[:deal_type] &&  params[:deal_type] != 'Any'
      conditions += " AND asset_id = '#{params[:deal_type]}'"
    end
    if params[:asset_type] &&  params[:asset_type] != 'Any'
      conditions += " AND asset_type_id = '#{params[:asset_type]}'"
    end
    if params[:sector] &&  params[:sector] != 'Any'
      joins += " inner join companies_sectors cs on cs.company_id = companies.id"
      conditions += " AND cs.sector_id = '#{params[:sector]}'"
    end
    if orderby=='usertype'
      joins += " left outer join roles_users ur on ur.user_id = companies.user_id inner join roles r on r.id = ur.role_id"
      order = "r.title #{sort}, "
    elsif orderby=='dealtype'
      joins += " left outer join assets ast on ast.id = companies.asset_id"
      order = "ast.name #{sort}, "
    elsif orderby=='financing'
      order = "companies.type_of_financing #{sort}, "
    elsif orderby=='geography'
      joins += " left outer join geographies g on g.id = companies.geography_id "
      order = "g.name #{sort}, "
    elsif orderby=='sector'
      joins +=" left outer join companies_sectors cs on cs.company_id = companies.id inner join sectors s on s.id = cs.sector_id "
      order = "s.name #{sort}, "
    elsif orderby=='size'
      order = "d.name #{sort}, "
    elsif orderby=='revenue'
      order = "companies.revenue_per_year #{sort}, "
    end
    order += "companies.id desc"
    amount_total= Company.sum(:all, :joins => joins, :conditions => conditions, :select => "d.size_in_billions")
    companies = Company.paginate(:all, :joins => joins, :conditions => conditions, :order => order, :page => page, :per_page => 10, :select => "companies.*")
    total = Company.count(:all, :joins => joins, :conditions => conditions)
    return companies, total, amount_total
  end

  def self.profile_results(page,user,type)
    conditions ="user_id =#{user} and company_type='#{type}'and status='approved'"
    Company.paginate(:all,:conditions => conditions,:page => page,:per_page =>5,:select => "companies.*")
  end

  def self.getheading(params)
    heading = "Directs/co-investments to #{(params[:type].eql?'sell')? 'sell' : 'buy'}"
#    search_parameters = 0
    if params[:deal_type] && params[:deal_type]!='Any'
       heading += " #{Asset.find(params[:deal_type]).name}"
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Asset.find(params[:deal_type]).name}"
#      search_parameters += 1
    end

#    if params[:asset_type] && params[:asset_type]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Asset.find(params[:asset_type]).name} Asset type"
#      search_parameters += 1
#    end
#    
#    if params[:geography] && params[:geography]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Geography.find(params[:geography]).name} Geography"
#      search_parameters += 1
#    end
#
#    if params[:sector] && params[:sector]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Sector.find(params[:sector]).name} Sector"
#      search_parameters += 1
#    end
#
#    if params[:financing] && params[:financing]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{params[:financing]} Financing"
#      search_parameters += 1
#    end
#
#    if params[:desired_size] && params[:desired_size]!='Any Size'
#      heading += "#{(search_parameters == 0)? '' : ', '}size #{params[:desired_size]}"
#      search_parameters += 1
#    end
#    
#    return (search_parameters == 0)? heading.gsub(' for ', '') : heading
    heading
  end
end
