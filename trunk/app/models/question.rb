class Question < ActiveRecord::Base
  has_many :answers
  has_many :options
  has_and_belongs_to_many :users
  has_and_belongs_to_many :roles

  validates_presence_of :questions

  QUESTION_TYPE =['multiple choice','text field', 'yes/no with option','yes/no without option']

  def yes_option
    self.options.find(:first, :conditions =>{:option=>"option_yes"})
  end

  def no_option
    self.options.find(:first, :conditions =>{:option=>"option_no"})
  end
end
