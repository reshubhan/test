class SavedSearch < ActiveRecord::Base
  belongs_to :user
  serialize :query, Hash
  validates_uniqueness_of :name  

  def self.save_search(params, user, search_type, name)
    create(:name => name, :query => params, :user_id => user, :search_type => search_type)
  end

end
