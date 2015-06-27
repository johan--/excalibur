json.cache! ['v1', @reservation], expires_in: 1.day do  
	json.id @reservation.id
	json.date_reserved @reservation.date_reserved
	json.start @reservation.start
	json.finish @reservation.finish
	json.created_at @reservation.created_at
	json.updated_at @reservation.updated_at
end  