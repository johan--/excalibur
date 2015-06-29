json.firms @firms do |firm|
	json.id @firm.id
	json.name @firm.name
	json.region @firm.region
	json.city @firm.city
	json.address @firm.address
	json.phone @firm.phone
end