json.cache! ['v1', @firm], expires_in: 1.day do  
	json.id @firm.id
	json.name @firm.name
	json.region @firm.region
	json.city @firm.city
	json.address @firm.address
	json.phone @firm.phone
end  