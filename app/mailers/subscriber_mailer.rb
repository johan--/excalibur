class SubscriberMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ENV["BASE_EMAIL"]

  def welcome(email, category)
    @landing = "siKapiten.com"
    @video = "http://www.youtube.com/watch?v=PtjetoVwBPw"
    @email = email
    if category == "registration"
    	@category = "client"
    else
    	@category = "financier"
    end 

    mail(to: email, subject: "Salam kenal dari siKapiten")
  end

end