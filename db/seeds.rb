# Generated with RailsBricks
# Initial seed file to use with Devise User Model

# Temporary admin account
u = User.new(
    email: "galih0muhammad@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    # first_name: "Galih",
    # last_name: "Muhammad",
    full_name: "Galih Muhammad",
    phone_number: "081399279500",
    admin: true
)
# u.skip_confirmation!
u.save!

# Test user accounts
(1..50).each do |i|
  u = User.new(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    full_name: "Example #{i}",
    phone_number: "0813992795#{i}",
  )
  # u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

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

venue_array = []
firm_array.each do |firm|
  venue_array << Venue.create!(
    name: "Arena 1",
    address: "Example Address No. 1",
    province: "DKI Jakarta",
    city: "Jakarta Selatan",
    phone: "08199999991",
    firm_id: firm.id
  )
end

venue_array.each do |venue|
  (1..4).each do |i|
    Court.create!(
      name: "Lapangan #{i}",
      price: 100000,
      unit: "Jam",
      category: 1,
      venue_id: venue.id
    )
  end
end