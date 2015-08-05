class SubscriberMailer < ActionMailer::Base
  default from: ENV["BASE_EMAIL"]

  def welcome(subscriber)
    @subscriber = subscriber
    mail(to: subscriber.email, subject: "Hai, salam kenal")
  end

	# def send_simple_message
	#   RestClient.post "https://api:key-68f3f57c99f53754962f35bc6feac9bf"\
	#   "@api.mailgun.net/v3/sandboxa088c93268cd4f84b27ef71464afc564.mailgun.org/messages",
	#   :from => "Mailgun Sandbox <postmaster@sandboxa088c93268cd4f84b27ef71464afc564.mailgun.org>",
	#   :to => "Galih Muhammad <galih0muhammad@gmail.com>",
	#   :subject => "Hello Galih Muhammad",
	#   :text => "Congratulations Galih Muhammad, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
	# end  
end