
# Temporary admin account
u = User.new(
    email: "galih@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    full_name: "Galih Muhammad",
    category: 3,
    admin: true
)
u.save!

u = User.new(
    email: "yusuf@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    full_name: "Yusuf Cahyo",
    category: 3,
    admin: true
)
u.save!

# Test user accounts
(1..25).each do |i|
  y = User.new(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    full_name: "Example #{i}",
    # phone_number: "0813992795#{i}",
    category: 1
  )
  # u.skip_confirmation!
  y.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end

manager_array = []
(1..5).each do |i|
  manager_array << User.create!(
    email: "manager#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    full_name: "Manager #{i}",
    # phone_number: "0813992795#{i}",
    category: 2
  )
  # u.skip_confirmation!
  # z.save!

  puts "#{i} test managers created..." if (i % 5 == 0)

end


firm_array = []
(1..5).each do |i|
  firm_array << Firm.create!(
    name: "Bisnis #{i}",
    city: "Jakarta Selatan",
    address: "Example Address No. #{i}",
    phone: "0819999999#{i}",
  )
    puts "#{i} test firms created..." if (i % 5 == 0)

end

firm_array.each do |firm|
  Subscription.create!(
    category: 1,
    start_date: Date.today,
    state: "aktif",
    firm: firm
  )
end

manager_array.each do |manager|
  firm_array.each do |firm|
    firm.rosters.create!(
      user: manager,
      # rosterable: firm,
      state: "aktif",
      role: 0
    )
  end
end
  
# dummy blog posts
(1..14).each do |i|
  p = Post.new(
    title: "Post No.#{i}",
    content_md: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.",
    draft: false,
    topic: "dummy",
    user: User.first
  )
  p.save!

  puts "#{i} dummy posts created..." if (i % 5 == 0)

end