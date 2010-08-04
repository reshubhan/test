#every 2.minutes do
#  runner "User.reminder_after_a_day"
#end
#
#every 1.hours do
#  runner "Manager.update_image_url"
#end
#
#every 24*7.hours do
#  runner "User.reminder_after_a_week"
#end

every 1.min do
  runner "Admin.db_backup"
  #rake "backup"
end

#every 3.hours do
#  runner "MyModel.some_process"
#  rake "my:rake:task"
#  command "/usr/bin/my_great_command"
#end