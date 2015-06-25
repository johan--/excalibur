class API::V1::BaseController < ActionController::Base
  before_action :authenticate_with_token!
  respond_to :json

  # private

  # Devise methods overwrites
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization']) 
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" }, 
                   status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present? 
  end

  # def authenticate
  # 	authenticate_token || render_unauthorized
  # end 

  # def authenticate_token
  #   authenticate_or_request_with_http_token do |token, options|
  #     @user = User.where(auth_token: token).first
  #   end
  # end

  # def render_unauthorized
  #   self.headers['WWW-Authenticate'] = 'Token realm="Application"'
  #   render json: 'Bad credentials', status: 401
  # end

end  
