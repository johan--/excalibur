module FormOptionsHelper

  def days_list
	[ [ "Senin", "Monday"], ["Selasa", "Tuesday"], ["Rabu", "Wednesday"],
	  ["Kamis", "Thursday"], ["Jumat", "Friday"], ["Sabtu", "Saturday"],
	  ["Minggu", "Sunday"] ]
  end


  def province_lists
  	[ "DKI Jakarta", "Banten", "Jawa Barat" ]
  end
  
	def all_hours
		[
			"01:00", "02:00", "03:00", "04:00", "05:00",
			"06:00", "07:00", "08:00", "09:00",
			"10:00", "11:00", "12:00", "13:00", "14:00", "15:00", 
			"16:00", "17:00", "18:00", "19:00", "20:00", 
			"21:00", "22:00", "23:00", "00:00"
		]		
	end

	def durations
		(1..4).map{ |h| ["#{h} Jam", h] }
	end

	def courts_of_venue(venue_id)
		Venue.find_by_id(venue_id).courts.all.map do |court| 
			[court.name, court.id] 
		end
	end

	def role_options
		[ ['Pemilik', 0], ['Pengelola', 1], ['Staff', 2] ]
	end

	def user_categories
		[ ['Pemain', 1], ['Pengelola Arena', 2] ]
	end

# Profile form options
	def offline_presence_options
		[ "Kantor Utama", "Kantor Cabang", "Toko", "Gerai" ]
	end

	def online_presence_options
		[ "Jaringan Sosial", "Messaging/Chatting App", "Email" ]
	end

	def last_education_options
		[ "Di bawah SMP", "SMA", "D3/Sarjana", "S2", "Doktoral dan seterusnya" ]
	end

	def marital_status_options
		["Menikah", "Belum Menikah"]
	end

# Tender form options
	def intent_assets_options
		[ "Mesin", "Persediaan/Stok", "Bangunan", "Komoditi" ]
	end

end