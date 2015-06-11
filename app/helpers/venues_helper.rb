module VenuesHelper

	def category_translated(category)
		if category == 1
			return 'Vinyl'
		elsif category == 2
			return 'Beton'
		elsif category == 3
			return 'Rumput Sintetis'
		elsif category == 4
			return 'Rumput'
		end		
	end




end
