require 'open-uri'
class Manager < ActiveRecord::Base
  attr_accessor :image_url
  attr_accessor :user_login
  attr_accessor :admined
  attr_accessor :plan_id
  attr_accessor :role_id

  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'
  validates_presence_of     :url
  validates_presence_of     :user_login, :message => "name is required", :if => :admined
  validates_presence_of     :name
  validates_presence_of     :geography_id
  validates_presence_of     :description
  validates_uniqueness_of   :name, :scope => [:name, :geography_id, :asset_primary_id], :message => "has already been taken, Name should be unique across Asset Class Primary and Geography."
  validates_format_of :url, :with =>/^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  validate do |manager|
    manager.errors.add_to_base("Asset Class Primary can't be blank") if manager.asset_primary_id.blank?
    manager.errors.add_to_base("Asset Class Primary cannot be the same as Asset Class Secondary") if manager.asset_primary_id == manager.asset_secondary_id
  end
  
  has_many :funds
  has_many :secondaries
  has_many :ratings
  has_many :comments
  has_many :asset_attribute_managers
  belongs_to :geography
  belongs_to :user
  belongs_to :primary_asset, :class_name => 'Asset', :foreign_key => 'asset_primary_id'
  belongs_to :secondary_asset, :class_name => 'Asset', :foreign_key => 'asset_secondary_id'
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
    
  def user_login
    user.login if user
  end

  def user_login=(login)
    self.user = User.find_by_login(login) unless login.blank?
  end
  
  def rating
    rating = Rating.average(:overall, :conditions => {:manager_id => self.id})
    return (rating == nil)? 0 : rating
  end
  
  def review_count
    Comment.count(:all, :conditions => {:manager_id => self.id, :status => "approved"})
  end
  
  def self.list(current_user)
    find(:all,:conditions => { :user_id =>current_user.id},:order => 'name')
  end

  def fund_in_market?
    in_market = false
    funds.each { |fund|
      if(fund.in_market)
        in_market = true
        break
      end
    }
    return in_market
  end

  def self.fetch_manager(manager_name, asset_id, geography_id)
    find(:first, :conditions => { :name => manager_name, :asset_primary_id => asset_id, :geography_id => geography_id })
  end
  
  def belongs_to_user(user)
    if self == user.manager
      return true
    elsif user.manager && (self.url == user.manager.url)
      return true
    else
      return false
    end
  end
  
  def rating_summary(column)
    Rating.average(column, :conditions => {:manager_id => self.id})
  end
  
  def recent_funds
    return Fund.find(:all, :conditions => " status='approved' and manager_id = #{self.id}", :order => "year DESC, created_at DESC", :limit => 2)
  end
  
  def fund_size
    if self.funds.size == 1
      return self.funds[0].size
    elsif self.funds.size > 1
      return self.recent_funds[0].size + self.recent_funds[1].size
    else
      return 0      
    end
  end

  def all_secondaries(secondary_type)
    Secondary.find(:all, :conditions => "manager_id = #{self.id} and secondary_type = '#{secondary_type}' and status='approved'")
  end

  private
 
  def image_url_provided?
    !self.image_url.blank?
  end
 
  def download_remote_image
    self.image = do_download_remote_image
    self.image_remote_url = image_url
  end
 
  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; "image_#{self.object_id}.jpg" end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

#  def self.manager_results1(limit, page, params)
#    joins = ''
#    conditions = "1"
#    join_type = 'LEFT OUTER JOIN'
#    hash['sectors'] = 'all' if hash['sectors'].eql?'2'
#    if hash['open'] or hash['buyer'] or hash['seller'] or hash['sectors']!='all'
#      join_type = 'INNER JOIN'
#    end
#    if hash['open']
#      joins += 'inner join funds on m.id = funds.manager_id'
#      conditions += " AND funds.in_market = 1"
#    end
#
#    if hash['buyer'] or hash['seller']
#      joins += ' inner join secondaries on m.id = secondaries.manager_id'
#      if hash['buyer'] and hash['seller']
#        conditions += " AND secondaries.secondary_type = 'Buy' OR secondaries.secondary_type = 'Sell'"
#      elsif hash['buyer']
#        conditions += " AND secondaries.secondary_type = 'Buy'"
#      elsif hash['seller']
#        conditions += " AND secondaries.secondary_type = 'Sell'"
#      end
#    end
#
#    if hash['geo'] != 'all'
#      conditions += " AND geography_id = #{hash['geo']}"
#    else
#      conditions += " AND geography_id in(select id from geographies)"
#    end
#
#    if hash['asset'] != 'all'
#      conditions += " AND asset_primary_id = #{hash['asset']}"
#    else
#      conditions +="AND asset_primary_id in(select asset_primary_id from managers)"
#
#    end
#
#    case hash['time']
#    when 'all'
#      conditions += " AND m.status='approved' "
#    when 'today'
#      conditions += " AND m.status='approved' AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 1 DAY ) AND CURDATE()+1"
#    when 'week'
#      conditions += " AND m.status='approved' AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 7 DAY ) AND CURDATE()+1"
#    when 'month'
#      conditions += " AND m.status='approved' AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 30 DAY ) AND CURDATE()+1"
#    end
#
#    case hash['browse_by']
#    when 'popular'
#      joins += ' left outer join comments on m.id = comments.manager_id'
#      order = " group by id order by m.featured DESC, count(IFNULL(comments.id,0)) DESC"
#    when 'rated'
#      joins += ' left outer join ratings on m.id = ratings.manager_id'
#      order = " group by id order by m.featured DESC, avg(ratings.overall) DESC"
#    when 'recent'
#      order = " order by m.featured desc , m.created_at DESC"
#    else
#      order = " order by m.featured desc ,m.id ASC"
#    end
#
#    apply_sector = ""
#    if hash['sectors'] != 'All' && hash['sectors'] != 'all'
#
#      #      attr = []
#
#      #      hash['sectors'].each { |sector| attr << " fs.sector_id = #{sector} " }
#
#      #      if not attr.blank?
#      apply_sector = " AND f.id in (SELECT fs.fund_id from funds_sectors fs where fs.sector_id = #{hash['sectors']})"
#      #      end
#    else
#      apply_sector = "AND f.id in (select fund_id from funds_sectors where sector_id in(select id from sectors)) "
#
#    end
#
#
#
#
#
#    apply_asset = ""
#
#    @managers = Manager.paginate_by_sql("SELECT m.* from
#                      ( SELECT m1.*, IFNULL(f.size,0) total FROM managers m1
#                            #{join_type} funds f ON f.manager_id = m1.id where 1 " + apply_asset + apply_sector +
#        " GROUP BY m1.id
#                            HAVING total >= #{hash['size_min']} and total <= #{hash['size_max']})m
#                            #{joins}
#                            WHERE #{conditions}
#                            #{order}",{:per_page => limit, :page => page || 1})
#  end

  def self.manager_results(limit, page, params)
    query = " select mgr.* from managers mgr "
    order =" order by featured desc,"
    if params['browseby'] && params['browseby']=='rated'
      query += " left outer join (select sum(overall +terms + strategy+team+performance) as browsevar,manager_id from ratings group by manager_id)  rmgr on mgr.id=rmgr.manager_id "
      order += " rmgr.browsevar desc  "
    elsif params['browseby'] && params['browseby']=='recent'
      order += " mgr.updated_at desc  "
    else
      query += " left outer join (select count(manager_id) as browsevar,manager_id from comments where status='approved' group by manager_id)  rmgr on mgr.id=rmgr.manager_id "
      order += " rmgr.browsevar desc  "
    end
    query += " where mgr.id in ( select id from (select m.id,IFNULL(f.size,0) as total from managers m "

    conditions= " where m.status='approved' "

    if params['geography'] && params['geography'] != 'All'
      conditions += " and geography_id = #{params['geography']} "
    end
    if params['asset'] && params['asset'] != 'All'
      conditions += " and (asset_primary_id = #{params['asset']} or m.asset_secondary_id = #{params['asset']} ) "
    end

    query += ' left outer join funds f on m.id = f.manager_id '
    #    conditions += " and f.status='approved' "
    if  params['open']=='true'
      conditions += " and f.in_market = 1"
    end
    if params['sector'] && params['sector'] != 'All'
      query += ' inner join funds_sectors fs on  f.id=fs.fund_id '
      conditions += " and fs.sector_id = #{params['sector']} "
    end

    if params['seller'] and params['seller']=='true'
      query += ' inner join secondaries ss on m.id = ss.manager_id '
      conditions += " and ss.secondary_type = 'sell'"
    end

    if params['buyer'] and  params['buyer']=='true'
      query += ' inner join secondaries sb on m.id = sb.manager_id '
      conditions += " and sb.secondary_type = 'buy'"
    end
    
  
    if  params['time'] && params['time']=='today'
      conditions += " AND m.status='approved'AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 0 DAY ) AND CURDATE()+1 "
    elsif params['time'] && params['time']=='week'
      conditions += " AND m.status='approved' AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 7 DAY ) AND CURDATE()+1"
    elsif params['time'] && params['time']=='month'
      conditions += " AND m.status='approved' AND m.created_at BETWEEN DATE_SUB( CURDATE() ,INTERVAL 30 DAY ) AND CURDATE()+1"
    end
    if  params['size_min'] or  params['size_max']
      minsize = params['size_min']? params['size_min'] : 0
      maxsize = params['size_max']? params['size_max'] : Fund.max_size_for_scroller
      conditions+=" group by m.id HAVING total >= "+ minsize + " and total <= " + maxsize
    end
    finalquery = query + conditions +" )as mgrtemp )" + order
    @managers = Manager.paginate_by_sql(finalquery,{:per_page => limit, :page => page || 1})
  end
  
  def self.update_image_url
    logger.info("UPDATING MANAGER IMAGE URL");
    begin
      managers = Manager.find_all_by_status("approved")
      managers.each { |manager|
        manager.image_url = APP_CONFIG["WEBSNAPR_URL"] + manager.url
        manager.save
      }
    rescue
    end
    logger.info("COMPLETED UPDATING MANAGER IMAGE URL");
  end

  def manager_changes
    @manager = Manager.find_all_by_name(:all, :conditions ["name != (Null)" || "url != (Null)"])
  end


end
