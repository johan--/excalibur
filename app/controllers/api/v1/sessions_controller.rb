class API::V1::SessionsController < API::V1::BaseController
  skip_before_action :authenticate_with_token!, only: [:create]

  api :POST, "/sessions", "Create a new session for user"
  description "Log in user via the API and pass in the authentication token for request into header"
  param :session, Hash do
    param :email, String
    param :password, String
  end
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

  api :DELETE, "/sessions/:id", "Regenerate an authentication token"
  description "Instead of signing out, generate a new authentication token"
  def destroy
    user = User.find_by(auth_token: params[:id])
    user.set_auth_token!
    user.save
    head 204
  end

end