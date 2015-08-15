source 'https://rubygems.org'
ruby '2.0.0'

# Standard Rails gems
gem 'rails', '4.2.0'
gem 'sass-rails', '5.0.2'
gem 'uglifier', '2.6.0'
gem 'coffee-rails', '4.1.0'
gem 'jquery-rails', '4.0.3'
gem 'turbolinks', '2.5.3'
gem 'jquery-turbolinks'

# Authentication
gem 'devise', '3.4.1'
gem 'omniauth'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# Analytics
gem 'ahoy_matey'
gem "chartkick"
gem 'groupdate'

# File Upload
gem 'attachinary', github: 'galliani/attachinary'
gem 'cloudinary', '~> 1.0.24'

# Email
gem 'griddler'
gem 'griddler-mandrill'

# Blog
gem 'acts_as_commentable_with_threading'
gem 'social-share-button', '~> 0.1.6'

# Necessities
  # Necessary for Windows OS (won't install on *nix systems)
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'bcrypt', '3.1.9'
gem 'kaminari', '0.16.2'
gem 'friendly_id', '5.1.0'
gem 'font-awesome-sass', '4.2.2'
gem 'bootstrap-sass', '3.3.3'
gem 'goldiloader'
gem 'simple_form'
gem 'pg'
gem 'public_activity'


# Complementary
gem 'nprogress-rails'
gem 'money-rails'
gem 'bootstrap-datepicker-rails'
gem "paranoia", "~> 2.0"
gem 'statesman', '~> 1.2.3'
gem 'redcarpet', '3.2.2'


# API
gem 'apipie-rails'
gem 'jbuilder', '2.2.6'


group :development, :test do
  gem 'thin', '1.5.1'
end

group :development, :test do
  gem 'byebug', '3.5.1'
  gem 'web-console', '2.0.0'
  gem 'figaro', '1.0.0'
  gem 'spring', '1.2.0'
end

group :test, :development do
	gem 'rspec-rails', '3.1.0'
  gem "shoulda-matchers"
	gem 'capybara', '~> 2.2.0'
	gem 'factory_girl_rails', '4.5.0'
	gem 'database_cleaner', '1.3.0'
  # gem 'faker', '~> 1.4.3'
  gem 'timecop'
  gem 'poltergeist'
  # gem 'phantomjs', :require => 'phantomjs/poltergeist'
  # gem 'selenium-webdriver', '~> 2.45.0'
end


group :production do
  gem 'rails_12factor'
  # gem "passenger", '4.0.59'
  gem 'puma'
end