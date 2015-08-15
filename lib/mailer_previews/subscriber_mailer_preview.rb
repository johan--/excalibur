class SubscriberMailerPreview < ActionMailer::Preview
  # default from: ENV["BASE_EMAIL"]

  def welcome_preview
    SubscriberMailer.welcome("galih0muhammad@gmail.com")
  end
end