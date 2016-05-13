# class InvoiceController < ApplicationController

#   def create
#   	@invoice = Invoice.new(invoice_params)

#   	if @invoice.save
#   	  flash[:notice] = 'Invoice berhasil dibuat'
#   	else
#   	  flash[:warning] = 'Invoice gagal dibuat'
#   	end
#   end


# private
#   def invoice_params
#   	params.require(:invoice).permit(
#   	  :amount, :invoiceable, :recipient, :category, :deadline
#   	)
#   end

# end