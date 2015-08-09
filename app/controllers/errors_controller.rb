class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :normal_nav
  
  def not_found
  	render(:status => 404)
  end

  def unprocessable
  	render(:status => 422)
  end

  def internal_server_error
  	render(:status => 500)
  end

end
