class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :delete, :destroy]

  def show
    # @pic = Cloudinary::Api.resource(@document.public_id)
  end

  def new
  	@document = Document.new
  end

  def create
  	@document = Document.new(document_params)
  	@document.owner = current_user

  	if @document.save
	    redirect_to user_root_path
	    flash[:notice] = 'Dokumen berhasil disimpan'
	  else
		  render :new
	  end
  end

  def edit
    @category = @document.category
  end

  def update
  end

  def destroy
    # Cloudinary::Api.delete_resources([@document.public_id], type: :private)
    Cloudinary::Uploader.destroy(@document.public_id, type: :private)
  	@document.destroy

    flash[:notice] = 'Dokumen berhasil dihapuskan'
    redirect_to user_path(current_user)
  end

  def delete
  end

private
  def set_document
  	@document = Document.friendly.find(params[:id])
  	# @document = Document.find(params[:id])
  end

  def document_params
  	params.require(:document).permit(
  	  :name, :category, :slug, :image_id, :doc_type,
  	  :bytes, :public_id,
  	  :owner_type, :owner_id, :owner
  	)
  end
end