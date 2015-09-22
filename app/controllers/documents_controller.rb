class DocumentsController < ApplicationController

  def new
  	@document = Document.new
  end

  def create
  	@document = Document.new(document_params)
  	@document.owner = current_user

  	if @document.save
	    redirect_to user_root_path
	    flash[:notice] = 'Berkas berhasil disimpan'
	else
		render :new
	end
  end



private

  def document_params
  	params.require(:document).permit(
  	  :name, :category, :location, :image_id,
  	  :bytes, :public_id,
  	  :owner_type, :owner_id, :owner, :proofs => []
  	)
  end
end