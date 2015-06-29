json.cache! ['v1', @court], expires_in: 1.day do  
	json.id @court.id
	json.name @court.name
	json.price @court.price
	json.unit @court.unit
	json.category @court.category
	json.venue_id @court.venue_id
end  