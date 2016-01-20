module TendersHelper

	def type(tender)
		tender.tenderable_type.downcase
		# send "#{type(tender)}_tender_path", tender
	end

	def show_tender_link(tender)
		send "tender_path", tender
	end

	def edit_tender_link(tender)
		send "edit_#{type(tender)}_tender_path", tender.starter, tender
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

  def tender_timeline_sign(tender)
  	if tender.state == 'open'
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-star-o"), 
			class: "timeline-badge primary", 
				:"data-toggle" => "tooltip", :"title" => "terbuka" )
  	elsif tender.state == 'closed'
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-lock"), 
			class: "timeline-badge default",
				:"data-toggle" => "tooltip", :"title" => "terkunci" )
  	elsif tender.state == 'success'
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-star"), 
			class: "timeline-badge success",
				:"data-toggle" => "tooltip", :"title" => "berhasil" )
  	elsif tender.state == 'dropped'
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-fire"), 
			class: "timeline-badge danger",
				:"data-toggle" => "tooltip", :"title" => "gagal")
	end  	
  end


end