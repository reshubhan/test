class PolpulateMailerTypes < ActiveRecord::Migration
  def self.up
    MailerType.create(:name=>"daily")
    MailerType.create(:name=>"weekly")
    MailerType.create(:name=>"monthly")
  end

  def self.down
    MailerType.find_by_name("daily").destroy
    MailerType.find_by_name("weekly").destroy
    MailerType.find_by_name("monthly").destroy
  end
end
