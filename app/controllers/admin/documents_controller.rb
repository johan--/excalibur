class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: [:show, :edit, :verify]

  def index
    @documents = Document.all
  end

  def show
  end

  def edit
  end

  def verify
  end

  private

  def set_reservaton
    @document = Document.find(params[:id])
  end

  # def user_params
  #   params.require(:user).permit(
  #   :email,
  #   :password,
  #   :admin,
  #   :locked
  #   )
  # end

end
