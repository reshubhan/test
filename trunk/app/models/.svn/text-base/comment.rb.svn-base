class Comment < ActiveRecord::Base
  belongs_to :manager
  belongs_to :user
  has_many :comment_ratings
  def self.per_page
    1
  end
end
