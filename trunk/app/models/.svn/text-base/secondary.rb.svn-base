class Secondary < ActiveRecord::Base
  attr_accessor             :user_login
  attr_accessor             :manager_name
  attr_accessor :admined
  validate :custom_message
  validates_presence_of     :secondary_type
  validates_presence_of     :user_login, :message => "name is required", :if => :admined
  validates_presence_of     :user_id
  # validates_presence_of     :fund_id
  validates_presence_of     :expected_price
  validates_presence_of     :commitment_size, :if => :type_sell
  validates_presence_of     :nav #:if => :type_sell
  validates_presence_of     :drawn # :if => :type_sell
  #  validates_presence_of     :description #, :if => :type_sell
  #  validates_presence_of     :bite_size, :if => :type_buy
  #  validates_presence_of     :notes, :if => :type_buy
 
  
  EXPECTED_PRICE = ['Premium', 'Par', 'Slight Discount (< 20%)', 'Large Discount (20%-50%)', 'Deep Discount (> 50%)']
  COMMITMENT_SIZE = ['<$5M','$5M-20M','>$20M']
  NAV = ['<$5M','$5M-20M','>$20M']
  DRAWN = ['Fully drawn', '> 50%', '< 50%', 'Not Applicable']
  belongs_to :manager
  belongs_to :user
  belongs_to :fund
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  belongs_to :net_asset_value, :class_name => 'DesiredSize', :foreign_key => 'nav'
  
  def user_login
    user.login if user
  end
  
  def user_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end

  def type_sell
    self.secondary_type == 'sell' ? true : false
  end
    
  def type_buy
    self.secondary_type == 'buy'? true : false
  end
  
  def self.total_net_asset_value
    Secondary.sum(:all, :joins => "inner join desired_sizes d on d.id = secondaries.nav", :conditions => "status='approved'", :select => "d.size_in_billions")
  end
  
  def self.paginate_results(params, orderby = nil, ascdesc = nil, page = 1)
    joins = "inner join managers mgr on secondaries.manager_id = mgr.id inner join assets ast on mgr.asset_primary_id = ast.id
             inner join desired_sizes d on d.id = secondaries.nav left join assets ast2 on mgr.asset_secondary_id = ast2.id"
    conditions = "secondaries.status='approved'"
    order = ""
    sort = ascdesc.blank? ? 'desc' : ascdesc
    type = params[:type].blank? ? 'buy' : params[:type]

    if orderby=='secondary'
      order = "mgr.name #{sort},"
    elsif orderby=='asset'
      order = "ast.name #{sort},"
    elsif orderby=='commitment_size'
      order = "secondaries.commitment_size #{sort},"
    elsif orderby=='net_asset_value'
      order = "d.name #{sort},"
    elsif orderby=='drawn'
      order = "secondaries.drawn #{sort},"
    elsif orderby=='expected_price'
      order = "secondaries.expected_price #{sort},"
    end
    #starting of all joins
    if params[:browse_by] && params[:browse_by]=='rated'
      joins += " left outer join (select avg(overall) as browsevar,manager_id from ratings group by manager_id) rmgr on mgr.id = rmgr.manager_id"
      order += " rmgr.browsevar desc"
    elsif params[:browse_by] && params[:browse_by]=='popular'
      joins += " left outer join (select count(manager_id) as browsevar,manager_id from comments group by manager_id) rmgr on mgr.id = rmgr.manager_id"
      order += " rmgr.browsevar desc"
    else
      order += " secondaries.updated_at desc"
    end
    
    #starting of conditions
    if params[:asset] && params[:asset] != 'Any'
      conditions += " AND (mgr.asset_primary_id = #{params[:asset]} OR mgr.asset_secondary_id = #{params[:asset]})"
    end
    if params[:geography] && params[:geography] != 'Any'
      conditions += " AND (mgr.geography_id = #{params[:geography]})"
    end
    if params[:nav] && params[:nav] != 'Any Size'
      conditions += " AND d.name = '#{params[:nav]}'"
    end
    if params[:expected_price] && params[:expected_price] != 'Any'
      conditions += " AND secondaries.expected_price = '#{params[:expected_price]}'"
    end
    if params[:drawn] && params[:drawn] != 'Any'
      conditions += " AND secondaries.drawn = '#{params[:drawn]}'"
    end
    #    if params[:manager_id] && params[:id]
    #      manager_id = params[:manager_id]
    #      type = params[:id]
    #      conditions += " AND secondaries.manager_id = '#{manager_id}' AND secondaries.secondary_type = '#{type}'"
    #    else
    conditions += " AND secondaries.secondary_type = '#{type}'"
    #    end
     
    amount_total= Secondary.sum(:all, :joins => joins, :conditions => conditions, :select => "d.size_in_billions")
    companies = Secondary.paginate(:all, :joins => joins, :conditions => conditions, :order => order, :page => page, :per_page => 10, :select => "secondaries.*")
    total = Secondary.count(:all, :joins => joins, :conditions => conditions)
    return companies, total, amount_total
  end

  def self.profile_results(page,user,type)
    conditions ="user_id =#{user} and secondary_type='#{type}' and status ='approved'"
    Secondary.paginate(:all,:conditions => conditions,:page => page,:per_page =>5,:select => "secondaries.*")
  end

  
  def self.listing_paginate(params)
    #
    #    id=params[:manager_id]
    #    type=params[:id]
    #    initalquery=" select * from secondaries   "
    #    condition=" where manager_id='#{id} 'and secondary_type='#{type}' "
    #    condition +="  and status ='approved ' "
    #    finalquery=initalquery+condition
    #
    #    Secondary.paginate_by_sql(finalquery,{:page => params[:page], :per_page => 10})
    @secondaries = Secondary.paginate :all, :page => params[:page], :per_page => 10, :conditions => {:manager_id => params[:id], :status => "approved"}, :order => "created_at desc"
  end

    
  def custom_message
    errors.add_to_base("Manager name  can't be blank.") if manager.blank?
    errors.add_to_base("Fund can't be blank.") if fund_id.blank?
  end
    
  def manager_name=(name)
    self.manager = Manager.find_by_name(name) unless name.blank?
  end
    
  def find_secondaries( )
    joins  = 'inner join managers on manager_id = managers.id'
    joins += ' inner join geography on manager.geography_id = geography.id'
  end

  def self.getheading(params, browseby)
    if params[:type].eql?'sell'
      heading = "Secondaries for sale"
    else
      heading = "Institutional Investors looking for secondaries to buy"
    end
#    heading = "#{(browseby.eql?'rated')? 'Highest Rated' : (browseby.eql?'recent')? 'Recently Added' : 'Most Popular'} Secondaries to #{(params[:type].eql?'sell')? 'sell' : 'buy'} representing up to $amountB for "
#    search_parameters = 0
    
    if params[:asset] && params[:asset]!='Any'
      heading += " #{Asset.find(params[:asset]).name}"
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Asset.find(params[:asset]).name} Asset"
#      search_parameters += 1
    end
    
#    if params[:geography] && params[:geography]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{Geography.find(params[:geography]).name} Geography"
#      search_parameters += 1
#    end
#
#    if params[:nav] && params[:nav]!='Any Size'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{params[:nav]} NAV"
#      search_parameters += 1
#    end
#
#    if params[:expected_price] && params[:expected_price]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{params[:expected_price]} Expected Price"
#      search_parameters += 1
#    end
#
#    if params[:drawn] && params[:drawn]!='Any'
#      heading += "#{(search_parameters == 0)? '' : ', '}#{params[:drawn]} Drawn"
#      search_parameters += 1
#    end
#
#    return (search_parameters == 0)? heading.gsub(' for ', '') : heading
    heading
  end
end
