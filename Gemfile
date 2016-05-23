source 'https://rubygems.org'
ruby "2.2.4"

# Standard Rails gems
gem "rails", "~> 4.2.0"
gem 'sass-rails', '5.0.2'
gem 'uglifier', '2.6.0'
gem 'coffee-rails', '4.1.0'
gem 'coffee-script-source', '1.8.0'
gem 'jquery-rails', '4.0.3'
gem 'turbolinks', '2.5.3'
gem 'jquery-turbolinks'

gem 'bootstrap-slider-rails', '6.0.6'

gem "high_voltage", '2.4.0'

# Authentication
gem 'devise', '3.4.1'
# gem 'omniauth'
gem 'omniauth-oauth2', '~> 1.3.1'
gem 'omniauth-facebook', '2.0.1'
gem "omniauth-google-oauth2", '0.2.6'
gem 'omniauth-linkedin-oauth2', '0.1.5'

# Analytics
gem 'mixpanel-ruby', '2.2.0'
gem 'meta_events', '1.2.1'

# File Upload
gem 'attachinary', '1.3.1'#, github: 'galliani/attachinary'
gem 'cloudinary', '~> 1.1.0'

# Blog
gem 'acts_as_commentable_with_threading'
gem 'social-share-button', '~> 0.2.1'
gem 'irwi', :git => 'git://github.com/alno/irwi.git'
# gem 'social-share-button', '~> 0.1.6'


# Necessities
  # Necessary for Windows OS (won't install on *nix systems)
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'bcrypt', '3.1.11'
gem 'kaminari', '0.16.2'
gem 'friendly_id', '5.1.0'
gem 'font-awesome-sass', '~> 4.5.0'
gem 'bootstrap-sass', '3.3.3'
gem 'goldiloader', '0.0.9'
gem 'simple_form', '3.2.1'
gem 'pg'
# gem 'public_activity'
gem 'metamagic', '3.1.7'
# gem 'inline_svg', '0.6.1'
gem 'wannabe_bool', '0.4.0'
gem 'browser'
gem 'vanity', :git => 'https://github.com/assaf/vanity', :branch => 'master'
gem 'protokoll', '1.0.2'
# gem 'groupify', '0.7.1'
gem 'wicked', '1.2.1'
gem 'pacecar', '2.0.0' #https://github.com/thoughtbot/pacecar
gem "socialization", "~> 1.2.0"

# Complementary
gem 'nprogress-rails', '0.1.6.7'
gem 'money-rails', '1.4.1'
# gem 'bootstrap-datepicker-rails'
gem "paranoia", "~> 2.0"
gem 'statesman', '~> 1.2.3'
gem 'redcarpet', '3.2.2'
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
gem 'geocoder', '1.2.14'
gem 'ionicons-rails'
gem 'active_link_to', '1.0.3'
gem 'impressionist'
gem 'gmaps4rails'
# gem "rails-settings-cached", "~> 0.4.0"
gem 'premailer-rails'
gem 'nokogiri'


group :development do
  # gem "mail_view", "~> 2.0.4"
  gem "awesome_print", require:"ap"
  gem "better_errors", '2.1.1'
  gem "binding_of_caller", '0.7.2'
  gem "quiet_assets", '1.1.0'
end

group :development, :test do
  gem 'thin', '1.5.1'
  gem 'byebug', '3.5.1'
  gem 'web-console', '2.0.0'
  gem 'figaro', '1.0.0'
  gem 'spring', '1.2.0'
  gem 'with_model'
  gem "bullet", '5.0.0'
  gem "bundler-audit", require: false  
end

group :test, :development do
  gem 'rspec-rails', '3.3.0'
	# gem 'rspec-rails', '3.4.2'
  gem 'rspec-retry'
	gem 'capybara', '~> 2.2.0'
	gem 'factory_girl_rails', '4.5.0'
  # gem 'faker', '~> 1.4.3'
  # gem 'phantomjs', :require => 'phantomjs/poltergeist'
end

group :test do
  # gem "formulaic"
  # gem 'timecop'
  gem 'poltergeist', '1.8.1'  
  gem 'database_cleaner', '1.3.0'
  gem "shoulda-matchers", '3.1.0'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'puma'
end