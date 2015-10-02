class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: [:show, :edit, :update]

  def index
    @admin = true
    @documents = Document.order(:created_at).page params[:page]
  end

  def show
    @admin = true
  end

  def update
    if @document.update(document_params)
      @document.transitioning!
      flash[:notice] = 'Dokumen berhasil dikoreksi'
      redirect_to admin_documents_path 
    else
      flash[:warning] = 'Dokumen gagal dikoreksi'
      render :index
    end    
  end

  private

  def set_document
    @document = Document.friendly.find(params[:id])
  end

  def document_params
    params.require(:document).permit(
    :checked,
    :flagged,
    :public_id
    )
  end

end
