module ReservationsHelper

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

end
