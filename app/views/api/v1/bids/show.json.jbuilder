json.cache! ['v1', @bid], expires_in: 1.day do  
	json.id @bid.id
	json.barcode @bid.barcode
	json.contribution @bid.contribution
	json.bidder_type @bid.bidder_type

	json.bidder @bid.bidder do |bidder|
    	json.(bidder, :id, :name, :about)
	end

	json.tender @bid.tender do |tender|
    	json.(tender, :id, :barcode, :category, :about, :target)
	end	
end