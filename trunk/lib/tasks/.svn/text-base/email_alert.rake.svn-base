desc "Email Alert Notification"

task :send_notifications => :environment do
  users = []
  current_notifications = []
  to_day = Date.today
  notifications = Notification.find(:all, :conditions => "status=1")
  notifications.each do |notification|
    if(notification.mailer_type.name=="daily" )
      current_notifications << notification
    elsif (notification.mailer_type.name=="weekly")
      if notification.iteration== to_day.wday
        current_notifications << notification
      end
    elsif (notification.mailer_type.name=="monthly")
      if notification.iteration== to_day.mday
        current_notifications << notification
      end
    end
  end
  current_notifications.each { |notice|
    notice.plans.each { |plan|
      users = users+User.find(:all, :conditions=>"plan_id=#{plan.id} and status='approved'")
    }
    users.each { |user|
      Mailer.deliver_notice(user,notice.subject,notice.body)
      puts "#{notice.subject} Email alert has been prepared to send on #{to_day} to #{user.profile.email}"
    }
    users.clear
  }
end