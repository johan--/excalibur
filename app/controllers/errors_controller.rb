class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  
  def not_found
    @static = true
  	render(:status => 404)
  end

  def unprocessable
    @static = true
  	render(:status => 422)
  end

  def internal_server_error
    @static = true
  	render(:status => 500)
  end

end
