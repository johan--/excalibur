class API::V1::SessionsController < API::V1::BaseController
  skip_before_action :authenticate_with_token!, only: [:create]

  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user#, store: false
      user.set_auth_token!
      user.save
      render json: user, status: 200, message: 'Berhasil login'
    else
      render json: { errors: "Gagal login, email atau password salah" }, status: 422
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    user.set_auth_token!
    user.save
    head 204
  end

end