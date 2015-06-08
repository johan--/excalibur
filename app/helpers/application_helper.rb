module ApplicationHelper
  def title(value)
    unless value.nil?
      # @title = "#{value} | Fustal"
      @title = "#{value}"
    end
  end

  def into_hub(user)
    if user.admin?
      admin_root_path
    elsif user.operator?
      biz_root_path
    else
      user_root_path
    end
  end

  def province_lists
  	[ "DKI Jakarta", "Banten", "Jawa Barat" ]
  end

  def reservation_state_sign(reservation)
  	if reservation.confirmed?
		content_tag(:div, 
			content_tag(:i, '', class: "glyphicon glyphicon-pushpin"), 
			class: "ticket-state bg-palegreen")
  	elsif reservation.completed?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-check"), 
			class: "ticket-state bg-palegreen")
  	elsif reservation.waiting?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-anchor"), 
			class: "ticket-state bg-palegreen")
  	elsif reservation.pending?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-warning"), 
			class: "ticket-state bg-coral")
  	elsif reservation.cancelled?
		content_tag(:div, 
			content_tag(:i, '', class: "glyphicon glyphicon-remove"), 
			class: "ticket-state bg-coral")			
  	end
  end

  def idr_money(number)
    number_to_currency(number, unit: "Rp ", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true, precision: 0)
# => R$1234567890,50
  end

  def idr_no_symbol(number)
    number_to_currency(number, unit: "", separator: ",", 
                       delimiter: ".", negative_format: "(%u%n)",
                       raise: true, precision: 0)
# => R$1234567890,50
  end

end
