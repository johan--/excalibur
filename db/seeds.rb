# # Temporary admin account
# User.create(email: "galih@gmail.com", password: "asdasdasd", 
#   password_confirmation: "asdasdasd", name: "galih muhammad", 
#   admin: true, understanding: "yes")

# # Test user accounts
# (1..10).each do |i|
#   User.create(
#     email: "user#{i}@example.com",
#     password: "1234567",
#     password_confirmation: "1234567",
#     name: "example #{i}",
#     understanding: "yes"
#   )

#   puts "#{i} test users created..." if (i % 5 == 0)

# end

# # dummy blog posts
# (1..10).each do |i|
#   p = Post.new(
#     title: "Post No.#{i}",
#     content_md: "Lorem Ipsum Dolor Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. consectetur purus sit amet fermentum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum.",
#     draft: false,
#     topic: "dummy",
#     tags_text: "test, lorem",
#     user: User.first
#   )
#   p.save!

#   puts "#{i} dummy posts created..." if (i % 5 == 0)

# end

# Houses
(1..5).each do |h|
  House.create(
  anno: 2015, price: 300000000, category: "rumah",
  address: "Cipete 7 No. #{h} RT 03 RW 04 Cipete Selatan, Cilandak",
  city: "Jakarta Selatan", province: 'DKI Jakarta', 
  publisher: User.first,
  for_sale: "yes", for_rent: "no", vacant: "yes",
  bedrooms: 3, bathrooms: 1, level: 1,
  garages: 1, lot_size: 100, property_size: 90    )
end

# Tender.create(
#     price: 300000, volume: 1000, annum: 10, draft: "no", aqad: "musharaka",
#     category: "fundraising", unit: "ownership", seed_capital: 20,
#     starter: User.first, tenderable: House.first.stocks.first
# )

# Bid.create(
#   tender: Tender.first, bidder: User.first, volume: 250
# )
# Bid.create(
#   tender: Tender.first, bidder: User.second, volume: 250
# )
# Bid.create(
#   tender: Tender.first, bidder: User.third, volume: 250
# )
# Bid.create(
#   tender: Tender.first, bidder: User.fourth, volume: 250
# )