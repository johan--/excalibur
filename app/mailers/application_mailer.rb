class ApplicationMailer < ActionMailer::Base
  default from: ENV["ZOHO_USERNAME"]
  layout 'mailer'


end
