# Temporary admin account
User.create(email: "galih@gmail.com", password: "asdasdasd", password_confirmation: "asdasdasd", name: "Galih Muhammad", client: true, financier: true, admin: true)

User.create(email: "pampam@gmail.com", password: "asdasdasd", password_confirmation: "asdasdasd", name: "Pampam", client: true, admin: true)

# Test user accounts
(1..25).each do |i|
  User.create(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    name: "Example #{i}",
    financier: true
  )

  puts "#{i} test users created..." if (i % 5 == 0)

end

# b = Business.create!(
#   name: "Bisnis 1",
#   anno: 2015,
#   about: "cloth dress jeans shirt jacket sock shoe",
#   founding_size: 3,
#   industry: "fesyen",
#   city: "Jakarta Selatan",
#   province: "DKI Jakarta",
#   starter_email: User.first.email
# )
  
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

# t = Tender.create(category: "Bisnis", aqad: "musharakah",
#           tenderable: b, target: 15000000,
#           intent_type: "Modal Kerja", intent_assets: "Persediaan/Stok",
#           summary: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula")

# t.bids.create(tender: t, bidder: User.second, contribution: 5000000)
# t.bids.create(tender: t, bidder: User.third, contribution: 5000000)
# t.bids.create(tender: t, bidder: User.fourth, contribution: 5000000)

# z = Tender.create(category: "Individu", aqad: "Musyarakah Mutanaqishah",
#           tenderable: User.last, target: 30000000, use_case: 'Pembelian',
#           tangible: "Rumah Tunggal", intent: "Tempat Tinggal",
#           price: 90000000,
#           address: "Jl. Cipete III No. 99 RT 01 RW 05 Cilandak, Jakarta Selatan",
#           summary: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula")