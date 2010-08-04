class Advert < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => "public/system/ads",
                 :max_size => 2.megabytes,
                 :partition => false,
                 :thumbnails => { :thumb => '30x30>', :medium => '125x125>' }

  validates_as_attachment
  has_many :geographies
  has_many :assets
end
