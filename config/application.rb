require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "attachinary/orm/active_record"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Fustal
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.i18n.available_locales = [:id, :en]
    # Default Locale
    config.i18n.default_locale = :en
    
    # Handles error via routes
    config.exceptions_app = self.routes

    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false

    # Test framework
    config.generators.test_framework false
    config.assets.initialize_on_precompile = false

    # autoload lib path
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Model folders
    config.autoload_paths += %W(#{config.root}/app/models/infos)
    config.autoload_paths += %W(#{config.root}/app/models/negotiations)
  end
end