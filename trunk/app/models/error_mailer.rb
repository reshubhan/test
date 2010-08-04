class ErrorMailer < ActionMailer::Base
  
  def snapshot(exception, trace, session, params, env, sent_on = Time.now)
    @recipients         = 'gauravsoni@neevtech.com'
    @from               = 'Local Error Mailer <error@duplays.com>'
    @subject            = "[Error] exception in #{env['REQUEST_URI']}"
    @sent_on            = sent_on
    @body["exception"]  = exception
    @body["trace"]      = trace
    @body["session"]    = session
    @body["params"]     = params
    @body["env"]        = env
  end
 
end

