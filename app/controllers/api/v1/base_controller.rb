class API::V1::BaseController < ActionController::Base
  include Authenticable
  protect_from_forgery with: :null_session
  before_action :authenticate_with_token!
  respond_to :json


end  
