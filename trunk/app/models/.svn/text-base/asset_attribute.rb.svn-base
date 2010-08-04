class AssetAttribute < ActiveRecord::Base

  belongs_to :asset
  belongs_to :attribute
  has_many :asset_attribute_managers, :dependent => :destroy

  def self.find_all_attributes_by_type(attr_type, asset_id)
    find(:all, :conditions => "attribute_type='#{attr_type}' and asset_id=#{asset_id}")
  end

  def self.get_attribute_count(manager_id, asset_id, type)
    arr=sum(:votes, 
      :group => "asset_attributes.id",
      :joins => "join asset_attribute_managers on asset_attribute_managers.asset_attribute_id=asset_attributes.id ",
      :conditions => ['asset_attributes.attribute_type = ? and asset_attribute_managers.manager_id = ? and asset_attributes.asset_id = ?', type, manager_id, asset_id] )
    arr.sort { |x,y| y[1].to_i<=>x[1].to_i }
  end
  
  def self.get_attribute_total_count(manager_id, asset_id, type)
    asset_attributes = self.get_attribute_count(manager_id, asset_id, type)
    count=0
    asset_attributes.each { |asset_attribute|
      count+=asset_attribute.last.to_i
    }
    count
  end
  
  def self.get_type_list(manager_id, asset_id, type)
    find(:all, 
      :group => "asset_attributes.id",
      :joins => "join asset_attribute_managers on asset_attribute_managers.asset_attribute_id=asset_attributes.id ",
      :conditions => ['asset_attributes.attribute_type = ? and asset_attribute_managers.manager_id = ? and asset_attributes.asset_id = ?', type, manager_id, asset_id] )
  end
  
end
