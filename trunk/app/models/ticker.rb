class Ticker < ActiveRecord::Base
  validates_presence_of :ticker_text, :message => "is blank"
end
