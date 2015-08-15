class SubscriberMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  default from: ENV["BASE_EMAIL"]

  def welcome(email)
    # @subscriber = subscriber
    mail(to: email, subject: "Hai, salam kenal")
  end

end