json.cache! ['v1', @venue], expires_in: 1.day do  
	json.id @venue.id
	json.name @venue.name
	json.province @venue.province
	json.city @venue.city
	json.address @venue.address
	json.phone @venue.phone
end  