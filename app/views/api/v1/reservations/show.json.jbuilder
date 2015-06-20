json.cache! ['v1', @reservation], expires_in: 1.day do  
  json.partial! 'reservation', reservation: @reservation
end  