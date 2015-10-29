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

# User options
	def user_category_options
		[ 
			["Klien - Membutuhkan pembiayaan", "client"], 
			["Pendana - Ingin berinvestasi", "financier"] 
		]
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
		["murabahah", "musyarakah mutanaqishah"]
	end

	def case_options
		["pembelian", "pembangunan", "perbaikan/renovasi", "pelunasan"]
	end

	def intent_options
		["tempat tinggal", "investasi"]
	end

	def tangible_options
		[ "rumah tunggal", "rumah koppel/gandeng", "town house", "rumah susun/flat", "tanah kosong" ]
	end

	def own_capital_options
		["10%", "20%", "30%", "40%", "50%", "60%", "80%", "90%"]
	end

  def published_options
  	[ ["Ya", true], ["Tidak", false] ]
  end
# Document options
	def document_categories
		["identitas", "bukti penghasilan", "bukti pengeluaran", 
			"bukti kepemilikan", "lain-lain"]
	end
	def identity_docs
		["KTP", "SIM", "Passport", "NPWP", "Kartu Keluarga", "Pas Foto"]
	end
	def employee_docs
		["Slip Gaji", "Surat Keterangan Masa Kerja"]
	end
	def entrepreneur_docs
		["Laporan Keuangan Bisnis", "Akte Perusahaan", "SIUP", "TDP"]
	end
	def professional_docs
		["Surat Izin Praktek", "Sertifikat Profesi"]
	end
	def earning_docs
		[employee_docs, entrepreneur_docs, professional_docs].flatten
	end

	def expense_docs
		["Buku Tabungan (4 Bulan Terakhir)", "Bukti Bayar Listrik", "Bukti Bayar Telepon",
			"Lain-lain"]
	end
	def collateral_docs
		["BPKB", "Girik", "SHGB", "SHGB", "SHM"]
	end
	def all_docs
		[identity_docs, earning_docs, expense_docs, collateral_docs].flatten
	end

end