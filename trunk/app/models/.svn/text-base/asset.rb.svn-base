class Asset < ActiveRecord::Base
  attr_accessor :has_parent

  validates_presence_of :name
  validates_uniqueness_of :name, :if => :is_valid_name
  
  has_many :asset_attributes
  has_many :subassets , :class_name => "Asset", :foreign_key => 'parent_id' ,:conditions =>{:default_asset => true}
  has_and_belongs_to_many :funds
  has_and_belongs_to_many :adverts
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  belongs_to :parent, :class_name => 'Asset'

  def is_valid_name
    if not self.parent
      return true
    else
      flag = false
      assets = Asset.find(:all, :conditions => {:parent_id => self.parent})
      assets.each do |asset|
        if self.name == asset.name and self.id.blank?
          flag = true
        end
      end
      return flag
    end
  end
  
  def self.list
    find(:all, :order => 'name')
  end

  def get_total_new_funds
    ClassifiedFund.count(:all,:conditions=>" status='approved' and asset_id=#{self.id}")
  end
  
  def get_total_new_fund_size
    ClassifiedFund.sum(:all, :joins => "inner join desired_sizes d on d.id = classified_funds.desired_size_id", :conditions => "status = 'approved' AND asset_id = #{self.id}", :select => "d.size_in_billions")
  end
  
  def self.list_parents
    assets = find(:all, :conditions => {:parent_id => nil}, :order => 'name')
    options = [{:val => ''}]
    assets.each do |asset|
      options.push({:val => asset.id, :label => asset.name})
    end
    options
  end

  def self.parents
    find(:all, :conditions => {:parent_id => nil}, :order => 'name')
  end

  def self.get_children(parent_id)
    if parent_id.eql?'Any'
      find(:all, :conditions => ["parent_id IS NOT NULL and active_asset=true"], :order => 'name')
    else
      find(:all, :conditions => {:parent_id => parent_id ,:active_asset =>true}, :order => 'name')
    end
  end

  def short_name
    name.length>15 ? name.slice(0,16)+"..." : name
  end

  def filter_name(type,asset)
    if type=="buy"
      ClassifiedFund.find_by_sql("select * from classified_funds where asset_id=#{asset.id} and status ='approved'and classified_fund_type='buy'").size
    else
      ClassifiedFund.find_by_sql("select cf.* from classified_funds cf inner join managers m on cf.manager_id=m.id   AND (m.asset_primary_id = #{asset.id} or m.asset_secondary_id = #{asset.id} )  and cf.classified_fund_type= 'sell'and cf.status='approved'").size
    end
  end

  def attributes
    attribs = []
    asset_attributes.each { |asset_attribute|
      attribs << asset_attribute.attribute if asset_attribute.attribute
    }
    attribs
  end

  def attribute_names
    names = []
    attributes.each { |attribute|
      names << "<a href='/attributes/#{attribute.id}/edit'>#{attribute.name}</a>"
    }
    names.join(",&nbsp;&nbsp;")
  end
  
end