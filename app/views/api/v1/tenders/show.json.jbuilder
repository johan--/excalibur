json.cache! ['v1', @tender], expires_in: 1.day do  
	json.id @tender.id
	json.barcode @tender.barcode
	json.category @tender.category
	json.summary @tender.summary
	json.aqad @tender.aqad
	json.target @tender.target

	json.tenderable @tender.tenderable do |tenderable|
    	json.(tenderable, :id, :type, :name, :about)
	end
end