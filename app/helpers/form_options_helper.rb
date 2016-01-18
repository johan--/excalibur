module FormOptionsHelper
  def boolean_options
  	[ ["True", true], ["False", false] ]
  end

  def yes_no_options
  	[ "yes", "no" ]
  end

  def currency_options
  	[ "idr", "usd" ]
  end

  def repayment_period_options
  	[ "weekly", "monthly", "retained" ]
  end

# Comment options
	def subject_options
		["assessment", "interaction"]
	end

# User options
	def user_category_options
		[ 
			["Klien - Membutuhkan pembiayaan", "client"]
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

	def intent_options
		["tempat tinggal", "investasi"]
	end

	def tender_unit_options
		[ "revenue shares", "ownership shares"]
	end

  def published_options
  	[ 'yes', 'no' ]
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

# Bid options
	def bid_states
		["belum diproses", "tentatif", "pasti", "batal"]
	end

# House options
	def house_categories
	  ["rumah", "apartemen"]
	end

	def house_states
	  ["for sale", "available", "for rent"]
	end
end