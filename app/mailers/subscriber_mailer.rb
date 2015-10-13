class SubscriberMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ENV["BASE_EMAIL"]

  def welcome(email)
    @landing = "siKapiten.com"
    @video = "http://www.youtube.com/watch?v=PtjetoVwBPw"
    @email = email
    mail(to: email, subject: "Salam kenal dari siKapiten")
  end

end