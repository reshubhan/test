class Mailer < ActionMailer::Base
  self.delivery_method = :activerecord
  
  def forgot_password(profile, new_password,login)
    recipients   profile.email
    from         "admin@trustedinsightinc.com"
    subject      "Your new password in Trusted Insight"
    body         :profile => profile, :new_password => new_password ,:login =>login
  end

  def password_account_activation_mail(profile,url)
    recipients   user.profile.email
    from         "admin@trustedinsightinc.com"
    subject       "Your new password in Trusted Insight"
    body         :profile => profile, :new_password => url
  end

  #  def newmailertemp(firstname, lastname,email, login,password)
  #    recipients   email
  #    from         "admin@trustedinsightinc.com"
  #    subject      "Your new crendentials in Trusted Insight"
  #    body         :firstname=>firstname,:lastname=>lastname,:login=>login, :password => password,:email=>email
  #  end
  
  def user_approval_mail(user)
    recipients   user.profile.email
    from         "admin@trustedinsightinc.com"
    subject      "Your new password"
    body         :user => user
  end

  def contact_mail(message, sender,toprofile,url_not_interested,url_reply_to)
    recipients   toprofile.email
    from        sender.profile.email
    subject      message.subject
    body        :sender => sender, :url1 => url_not_interested, :url2 => url_reply_to, :message => message
    bcc         "admin@trustedinsightinc.com"
    content_type "text/html"
  end

  def response_mail(receiver,message,desc)
    recipients   receiver
    from         "no-reply@trustedinsight.com"
    subject      "Re:Not Interested-#{message.subject} "
    body         "Dear #{message.sender.fullname},  <br/><br/>Unfortunately, there is no interest in your email response to the posting #{desc}<br/>Please try responding to a different posting."
    bcc         "admin@trustedinsightinc.com"
    content_type "text/html"
  end

  def interested_reply_to_mail(receiver,message,desc)
    recipients   "#{receiver}"
    from        message.sender.profile.email
    subject      "Re:Interested-#{message.subject} "
    body         "Dear #{message.sender.fullname},  <br/><br/>Congrats, there was a interest in your email response to the posting #{desc}<br/>Please try responding to it."
    bcc         "admin@trustedinsightinc.com"
    content_type "text/html"
  end

  def account_activation_mail(user, url)
    recipients   user.profile.email
    from         "admin@trustedinsightinc.com"
    subject      "Trusted Insight : Please activate your new account"
    bcc          "trustedinsight@gmail.com"
    body         :user => user, :url => url
  end

  def payment_receipt_mail(order)
    user = order.user
    recipients   user.profile.email
    bcc          "amarsingh@neevtech.com"
    from         "admin@trustedinsightinc.com"
    subject      "Trusted Insight : Payment Receipt"
    body         :order =>order, :user=>user
  end

  def manager_account_upgrade_mail(user,url)
    recipients   user.profile.email
    from         "admin@trustedinsightinc.com"
    subject      "Global Investors looking to invest in your asset class."
    body         :user => user,:url=> url
    content_type "text/html"
  end
  
  def email_alert_mail(user_name,user_login,type)
    recipients   "admin@trustedinsightinc.com"
    bcc          "amarsingh@neevtech.com"
    from         "admin@trustedinsightinc.com"
    subject      "User has put email in the description."
    body         " User with login #{user_login} and name #{user_name} of Trusted Insight has put email in the #{type} description."
    content_type "text/html"
  end

  def notice(user, subject, body)
    recipients   user.profile.email
    bcc          "amarsingh@neevtech.com"
    from         "admin@trustedinsightinc.com"
    subject      subject
    body         body
    content_type "text/html"
  end

  def invite_freinds(sender_id,sender_name,id,url)
    recipients   id.to_s
    from         sender_id
    subject      "You are invited join TrustedInsight"
    body         :sender => sender_name ,:url =>url
    reply_to     sender_id
    content_type "text/html"
  end

  def user_details(user)
    recipients   "trustedinsight@gmail.com"
    bcc          "amarsingh@neevtech.com"
    from         "admin@trustedinsightinc.com"
    subject      "Details of the user signed in Trustedinsight."
    body         :user =>user
    content_type "text/html"
  end


end
