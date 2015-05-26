json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :date_reserved, :court_id
  json.start reservation.start
  json.end reservation.finish
  json.url reservation_url(reservation, format: :html)
end
