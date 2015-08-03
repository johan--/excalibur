json.tenders @tenders do |tender|
	json.id tender.id
	json.barcode tender.barcode
	json.category tender.category
	json.summary tender.summary
	json.aqad tender.aqad
	json.target tender.target
	json.tenderable_type tender.tenderable_type
	json.tenderable_id tender.tenderable_id
end