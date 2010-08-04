class Attribute < ActiveRecord::Base
  has_many :asset_attributes, :dependent => :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
  belongs_to :updater, :class_name => 'User', :foreign_key => 'updated_by'
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.list(attributetype)
    find(:all,:conditions => { :attributetype => attributetype},:order => 'name')
  end

  def assets
    items = []
    asset_attributes.each { |asset_attribute|
      items << asset_attribute.asset if asset_attribute.asset
    }
    items
  end

  def asset_names
    names = []
    assets.each { |asset|
      names << "<a href='/assets/#{asset.id}/edit'>#{asset.name}</a>"
    }
    names.join(",&nbsp;&nbsp;")
  end
end