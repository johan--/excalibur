class EmailProcessor

  def initialize(email)
  	@email = email
  end

  def process
    # All of your custom logic for handling the email 
    #object will be in here!

    # this is to check if sender is registered user
    # author = User.where( email: @email.from ).first

    # Now we need to determine exactly what the email is for.
    # we accept inbound emails for a number of situations.
    # The destination email address is the key to determining the user's intention.
    if match = @email.to.first[:token].match(/^management/i)
      # Create a new contact message from the email
      Contact.create(
        message: @email.body,
        email: @email.from,
        name: @email.to.first[:name]
        )
    end
    
  end

end