# Temporary admin account
User.create(email: "galih@gmail.com", password: "asdasdasd", 
  password_confirmation: "asdasdasd", name: "Galih Muhammad", 
  admin: true, understanding: "true")

User.create(email: "pampam@gmail.com", password: "asdasdasd", 
  password_confirmation: "asdasdasd", name: "Pampam", 
  admin: true, understanding: "true")

# Test user accounts
(1..10).each do |i|
  User.create(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    name: "Example #{i}",
    understanding: "true"
  )

  puts "#{i} test users created..." if (i % 5 == 0)

end

  
# dummy blog posts
(1..10).each do |i|
  p = Post.new(
    title: "Post No.#{i}",
    content_md: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.",
    draft: false,
    topic: "dummy",
    tags_text: "test, lorem",
    user: User.first
  )
  p.save!

  puts "#{i} dummy posts created..." if (i % 5 == 0)

end