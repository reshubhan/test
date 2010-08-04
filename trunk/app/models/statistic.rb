class Statistic < ActiveRecord::Base
  validates_presence_of :statistic_text, :message => "is blank"
end
