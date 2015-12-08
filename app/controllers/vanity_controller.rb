class VanityController < ApplicationController
  include Vanity::Rails::Dashboard
  layout false  # exclude this if you want to use your application layout
  # before_filter :require_admin!, except: [:add_participant, :chooses]

end
