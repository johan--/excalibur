class ContactMailerPreview < ActionMailer::Preview

  def contact_message_preview
    ContactMailer.contact_message("Galih", "galih0muhammad@gmail.com", "he finds her waiting like a lonesome queen")
  end
end