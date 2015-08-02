# Temporary admin account
User.create(
    email: "galih@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    name: "Galih Muhammad",
    business: true,
    investor: true,
    admin: true
)

User.create(
    email: "yusuf@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    name: "Yusuf Cahyo",
    business: true,
    admin: true
)

# Test user accounts
(1..25).each do |i|
  User.create(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    name: "Example #{i}",
    investor: true
  )

  puts "#{i} test users created..." if (i % 5 == 0)

end

b = Business.create!(
  name: "Bisnis 1",
  anno: 2015,
  starter_email: User.first.email
)
  
# dummy blog posts
(1..10).each do |i|
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

t = Tender.create(category: "Bisnis", aqad: "musharakah",
          tenderable: b, target: 15000000,
          intent_type: "Modal Kerja", intent_assets: "Persediaan/Stok",
          summary: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula")

t.bids.create(tender: t, bidder: User.second, contribution: 5000000)
t.bids.create(tender: t, bidder: User.third, contribution: 5000000)
t.bids.create(tender: t, bidder: User.fourth, contribution: 5000000)

z = Tender.create(category: "Individu", aqad: "murabahah",
          tenderable: User.last, target: 8000000,
          intent_type: "Konsumsi", intent_assets: "Kendaraan Bermotor",
          summary: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula")