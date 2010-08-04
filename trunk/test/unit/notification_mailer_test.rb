require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "mail_notification" do
    @expected.subject = 'NotificationMailer#mail_notification'
    @expected.body    = read_fixture('mail_notification')
    @expected.date    = Time.now

    assert_equal @expected.encoded, NotificationMailer.create_mail_notification(@expected.date).encoded
  end

end
