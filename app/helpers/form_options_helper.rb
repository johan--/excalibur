module FormOptionsHelper

	def hours_available
		[
			["1", "01"], ["2", "02"], ["3", "03"], ["4", "04"], ["5", "05"],
			["6", "06"], ["7", "07"], ["8", "08"], ["9", "09"],
			["10", "10"], ["11", "11"], ["12", "12"], ["13", "13"],
			["14", "14"], ["15", "15"], ["16", "16"], ["17", "17"],
			["18", "18"], ["19", "19"], ["20", "20"], ["21", "21"],
			["22", "22"], ["23", "23"], ["24", "24"], ["00", "00"],
		]
	end

	def courts_of_venue(venue_id)
		Venue.find_by_id(venue_id).courts.all.map do |court| 
			[court.name, court.id] 
		end
	end

	def related_reservations
		if params[:reservation]
			params[:reservation]
		else
			current_user.current_reservations.map{ |res| [res.code, res.id] }
		end
	end

	def role_options
		[ ['Pemilik', 0], ['Pengelola', 1], ['Staff', 2] ]
	end

	def user_categories
		[ ['Pemain', 1], ['Pengelola Arena', 2] ]
	end

end