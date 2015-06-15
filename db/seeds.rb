Generated with RailsBricks
Initial seed file to use with Devise User Model

Temporary admin account
u = User.new(
    email: "galih@gmail.com",
    password: "asdasdasd",
    password_confirmation: "asdasdasd",
    # first_name: "Galih",
    # last_name: "Muhammad",
    full_name: "Galih Muhammad",
    phone_number: "081399279500",
    category: 3,
    admin: true
)
# u.skip_confirmation!
u.save!

# Test user accounts
(1..25).each do |i|
  y = User.new(
    email: "user#{i}@example.com",
    password: "1234567",
    password_confirmation: "1234567",
    full_name: "Example #{i}",
    phone_number: "0813992795#{i}",
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
    phone_number: "0813992795#{i}",
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

court_array = []
venue_array.each do |venue|
  (1..4).each do |i|
    court_array << Court.create!(
      name: "Lapangan #{i}",
      price: 100000,
      unit: "Jam",
      category: 1,
      venue_id: venue.id
    )
  end
end

court_array.each do |court|
  (1..3).each do |i|
    Reservation.create!(
      date_reserved: "10/05/2015",
      start: "15:00",
      duration: 2,
      category: 1,
      venue_id: court.id
      booker: u
    )
  end
end
  
a = Reservation.create!(
  date_reserved: 20.days.from_now.to_date,
  start: "15:00",
  duration: 2,
  court: Court.first,
  booker: User.first
)

b = a.dup 
b.court_id = 1
b.booker = User.second
b.save!

c = a.dup 
c.court_id = 1
c.booker = User.third
c.save!