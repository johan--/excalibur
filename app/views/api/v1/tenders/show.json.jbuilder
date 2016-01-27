json.cache! ['v1', @tender], expires_in: 1.day do  
	json.id @tender.id
	json.barcode @tender.barcode
	json.category @tender.category
	json.summary @tender.summary
	json.aqad @tender.aqad
	json.target @tender.target

	json.starter @tender.starter do |starter|
    	json.(starter, :id, :type, :name, :about)
	end
end