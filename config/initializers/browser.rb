Rails.configuration.middleware.use Browser::Middleware do
  unless browser.modern? || request.env['PATH_INFO'] == ['/', '/posts']
  	redirect_to upgrade_path 
  end
end