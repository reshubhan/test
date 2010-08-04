class Notification < ActiveRecord::Base
  validates_presence_of :name, :subject, :body
  has_and_belongs_to_many :users
  has_and_belongs_to_many :plans
  belongs_to :mailer_type

  WEEKDAYS = {"Monday" => 1,"Tuesday" => 2,"Wednesday" => 3,"Thursday" => 4,"Friday" => 5,"Saturday" => 6,"Sunday" => 0}
  DAYS = 1..31
end
