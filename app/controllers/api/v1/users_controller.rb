class API::V1::UsersController < API::V1::BaseController
  skip_before_action :authenticate_with_token!, only: [:create]

  def show
	@user = User.find(params[:id])
	# respond_with User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201, message: 'Pengguna berhasil dibuat'
    else
      render json: { errors: 'Pengguna gagal dibuat' }, status: 422
    end
  end

  def update
    @user = User.find(params[:id])

	if @user.update(user_params)
	  render json: @user, status: 200, message: 'Pengguna berhasil dikoreksi'
	else
	  render json: { errors: 'Pengguna gagal dikoreksi' }, status: 422
	end
  end

  private

    def user_params
      params.require(:user).permit(
      	:email, :password, :password_confirmation, 
      	:full_name, :category
      )
    end

end