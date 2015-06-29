json.venues @venues do |venue|
	json.id venue.id
	json.name venue.name
	json.province venue.province
	json.city venue.city
	json.address venue.address
	json.phone venue.phone
end