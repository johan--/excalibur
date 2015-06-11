module ReservationsHelper

  def reservation_state_sign(reservation)
  	if reservation.confirmed?
		content_tag(:div, 
			content_tag(:i, '', class: "glyphicon glyphicon-pushpin"), 
			class: "ticket-state bg-palegreen", 
				:"data-toggle" => "tooltip", :"title" => "sudah dibayar" )
  	elsif reservation.completed?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-check"), 
			class: "ticket-state bg-palegreen",
				:"data-toggle" => "tooltip", :"title" => "transaksi selesai" )
  	elsif reservation.waiting?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-anchor"), 
			class: "ticket-state bg-palegreen",
				:"data-toggle" => "tooltip", :"title" => "waiting list" )
  	elsif reservation.pending?
		content_tag(:div, 
			content_tag(:i, '', class: "fa fa-warning"), 
			class: "ticket-state bg-coral",
				:"data-toggle" => "tooltip", :"title" => "belum dibayar")
  	elsif reservation.cancelled?
		content_tag(:div, 
			content_tag(:i, '', class: "glyphicon glyphicon-remove"), 
			class: "ticket-state bg-coral",
				:"data-toggle" => "tooltip", :"title" => "dibatalkan" )
  	end
  end

  def state_label(reservation)
  	if reservation.confirmed?
		content_tag(:span, reservation.state, class: "label label-success", 
				:"data-toggle" => "tooltip", :"title" => "sudah dibayar" )
  	elsif reservation.completed?
		content_tag(:span, reservation.state, class: "label label-success",
				:"data-toggle" => "tooltip", :"title" => "transaksi selesai" )
  	elsif reservation.waiting?
		content_tag(:span, 	reservation.state, class: "label label-success",
				:"data-toggle" => "tooltip", :"title" => "waiting list" )
  	elsif reservation.pending?
		content_tag(:span, 	reservation.state, class: "label label-warning",
				:"data-toggle" => "tooltip", :"title" => "belum dibayar")
  	elsif reservation.cancelled?
		content_tag(:span, 	reservation.state, class: "label label-danger",
				:"data-toggle" => "tooltip", :"title" => "dibatalkan" )
  	end
  end


end
