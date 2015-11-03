module TendersHelper

	def type(tender)
		tender.tenderable_type.downcase
		# send "#{type(tender)}_tender_path", tender
	end

	def show_tender_link(tender)
		send "tender_path", tender
	end

	def edit_tender_link(tender)
		send "edit_#{type(tender)}_tender_path", tender.tenderable, tender
	end

	def draft_or_real?(tender)
		if tender.published?
			return "Telah dipublikasikan"
		else
			return "Belum dipublikasikan"
		end
	end

	def gain_from(aqad)
		if aqad == 'murabahah'
			return "Margin Penjualan"
		elsif aqad == 'musyarakah'
			return "Sewa"
		end
	end

	def gain_amount(tender, profit)
		if tender.aqad == 'murabahah'
			return idr_money(profit)
		elsif tender.aqad == 'musyarakah'
			return profit
		end		
	end

	# def bid_tender_link(tender)
	# 	tenderable = tender.tenderable_type.downcase
	# 	link_to "Buat Tawaran", new_tender_bid_path(tender)
	# end

	# def tender_action_heading
	# 	if current_page?(new_company_profile_path) || current_page?(new_user_profile_path)
	# 		return "Buat Profil"
	# 	else
	# 		return "Edit Profil"
	# 	end
	# end

	# def tender_type(category)
	# 	if category == 'CompanyProfile'
	# 		return "Bisnis"
	# 	elsif category == 'UserProfile'
	# 		return "Pengguna"
	# 	end
	# end

end
