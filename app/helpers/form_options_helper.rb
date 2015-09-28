module FormOptionsHelper
  def boolean_options
  	[ ["True", true], ["False", false] ]
  end

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

	def role_options
		[ ['Pemilik', 0], ['Pengelola', 1], ['Staff', 2] ]
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
	def aqad_options
		["Murabahah lil Amri bil Shira", "Musyarakah Mutanaqishah"]
	end

	def case_options
		["Pembelian", "Pembangunan", "Perbaikan/Renovasi", "Pelunasan"]
	end

	def intent_options
		["Tempat Tinggal", "Investasi"]
	end

	def tangible_options
		[ "Rumah Tunggal", "Rumah Koppel/Gandeng", "Rumah Town House", "Rumah Susun/Flat", "Tanah Kosong" ]
	end

	def own_capital_options
		["10%", "20%", "30%", "40%", "50%", "60%"]
	end


# Document options
	def document_categories
		["Identifikasi", "Sertifikat Pencapaian", "Bukti Kepemilikan", 
		 "Bukti Penghasilan", "Bukti Pengeluaran", "Lain-lain"]
	end


end