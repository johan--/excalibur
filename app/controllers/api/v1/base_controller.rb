class API::V1::BaseController < ActionController::Base
  include Authenticable
  before_action :authenticate_with_token!
  respond_to :json


end  
