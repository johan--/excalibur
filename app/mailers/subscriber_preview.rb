if Rails.env.development?
	class SubscriberPreview < MailView

	  # Pull data from existing fixtures / dev data
	  def welcome
	    email = "galih0muhammad@gmail.com"
	    mail = SubscriberMailer.welcome(email)
	    mail
	  end


	end
end