json.bids @bid do |bid|
	json.id bid.id
	json.barcode bid.barcode
	json.summary bid.summary
	json.contribution bid.contribution
	json.bidder_type bid.bidder_type
	json.bidder_id bid.bidder_id

	json.tender @bid.tender do |tender|
    	json.(tender, :id, :category, :barcode, :about, :target)
	end
end