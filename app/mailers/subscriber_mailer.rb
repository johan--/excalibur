class SubscriberMailer < ActionMailer::Base
  default from: "business@sikapiten.com"

  def welcome(subscriber)
    @subscriber = subscriber
    mail(to: subscriber.email, subject: "Hai, salam kenal")
  end
end