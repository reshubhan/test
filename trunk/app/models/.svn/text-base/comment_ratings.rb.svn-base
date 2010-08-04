class CommentRatings < ActiveRecord::Base
  validates_uniqueness_of   :comment_id, :scope => [:user_id], :message => "has already been taken this user."
  
  belongs_to :comment
  belongs_to :user
end
