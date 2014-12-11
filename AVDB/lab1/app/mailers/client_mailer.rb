class ClientMailer < ActionMailer::Base

  default from: 'amazing@site.com'

  def notification_email(email, body)
    mail(to: email,
         body: body,
         content_type: "text/html",
         subject: "Already rendered!")
  end

end
