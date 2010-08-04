class Webinar < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :speaker
  validates_presence_of :date
  validates_presence_of :link
end
