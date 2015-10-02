$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  linkclass = link.attr 'class'
  link.removeAttr('data-confirm')
  link.trigger('click.rails')
  
  if linkclass == 'reset-link'
  	window.location.replace(""+link.context.href+"");

$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  object = link.attr 'data-object'
  html = """
         <div class="modal" id="confirmationDialog">
		  <div class="modal-dialog">
		    <div class="modal-content">
			  <div class="modal-header modal-header-warning">
			    <a class="close" data-dismiss="modal">×</a>
				<h3>Konfirmasi</h3>
			  </div>
			  <div class="modal-body">
			    <center>
			      <h3 class="media-heading">#{object}</h3>
			  	  <p>#{message}</p>
				</center>
			  </div>
			  <div class="modal-footer">
            	<a data-dismiss="modal" class="btn btn-warning">Batalkan</a>
             	<a data-dismiss="modal" class="btn btn-primary confirm">Ya, lanjutkan</a>
			  </div>		    
		    </div>
		  </div>
         </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)  