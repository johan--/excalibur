class ContactMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  # default from: ENV["BASE_EMAIL"]
  default from: ENV["ZOHO_USERNAME"]


  def contact_message(name, email, message)
    @name = name
    @email = email
    @message = message

    mail to: ENV["SENDER_EMAIL"], subject: "New message received at #{ENV["DOMAIN"]}"
  end

  def request_funding_message(name, email, message)
    @name = name
    @email = email
    @message = message

    mail to: ENV["SENDER_EMAIL"], subject: "#{@name.upcase} - Permintaan Pendanaan"
  end  
end
