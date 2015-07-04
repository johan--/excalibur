class API::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  include Authenticable
  before_action :authenticate_with_token!
  respond_to :json


end  
