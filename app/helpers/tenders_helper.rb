module TendersHelper


	def type(tender)
		tender.tenderable_type.downcase
		# send "#{type(tender)}_tender_path", tender
	end

	def render_blank_or_show(tenders)
		if tenders.blank?
			return "tidak ada proposal saat ini"
		else
			render partial: 'tenders/tender', collection: tenders
		end
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

  def annum_label(tender)
  	if tender.aqad == 'murabaha'
  	  "Lama Cicilan"
  	elsif tender.aqad == 'musharaka'
  	  "Lama Syirkah"
  	end
  end

  def seed_label(tender)
  	if tender.aqad == 'murabaha'
  	  "Uang Muka"
  	elsif tender.aqad == 'musharaka'
  	  "Modal Kamu"
  	end
  end

  def render_progress_bar(value)
  	content_tag(:div, 
  		content_tag(:span, "#{value}% Tercapai", class: "show", id: 'progress-info'), 
  		class: "progress-bar", 
  		:"role" => "progressbar", 
  		:"aria-valuenow" => "#{value}", :"aria-valuemin" => "0",
  		:"aria-valuemax" => "100", :"style" => "width: #{value}%;"
  	)
  end

  def calculate_progress(tender)
    (tender.check_contribution / tender.target)
  end  

  def render_tender_thumb(tender, string)
  	cl_image_tag(tender.tenderable.display_picture('id'), house_tender_options(string))
  end  
end