class DesiredSize < ActiveRecord::Base
  has_many :classified_funds
  has_many :companies
  has_many :secondaries
end
