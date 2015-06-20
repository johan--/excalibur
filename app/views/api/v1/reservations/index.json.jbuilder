json.reservations @reservations do |reservation|
  json.partial! 'reservation', reservation: reservation
end