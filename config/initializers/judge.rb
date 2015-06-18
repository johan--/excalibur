Judge.configure do

  # For validating uniqueness
  # expose Post, :title, :body
  expose User, :email

end