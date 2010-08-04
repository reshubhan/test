desc "Email expiring accounts to let them know"
task :email_expiring => :environment do
  emails = Email.find(:all, :conditions => ['last_send_attempt = 0'])
  emails.each do |email|
    NotificationMailer.deliver_mail_notification(email)
  end
  emails.each do |email|
    begin
      email.update_attribute(:last_send_attempt, 1)
    rescue
      email.destroy
    end
  end
end
