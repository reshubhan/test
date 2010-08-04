class AssetAttributeManager < ActiveRecord::Base
  belongs_to :manager
  belongs_to :user
  belongs_to :asset_attribute
end
