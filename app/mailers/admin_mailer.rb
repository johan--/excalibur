require 'open-uri'

class AdminMailer < ActionMailer::Base
  add_template_helper(EmailHelper)
  # default from: "from@example.com"
  # layout 'mailer'

  def admin_outbound(email, from, subject, message, file)
    @email = email
    @message = message

    unless file.nil?
    	# @upload = Cloudinary::Uploader.upload(
    	# 	File.open(file.path), public_id: file.original_filename, 
    	# 		:resource_type => :auto)
    	
    	attachments["attachment"] = open(file).read
    	# attachments[file.original_filename] = File.read(file.path)
    end
    mail(from: from, to: email, subject: subject)  	
  end

end