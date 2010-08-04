class Option < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer

  validates_presence_of :option
end
