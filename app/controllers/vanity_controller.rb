class VanityController < ApplicationController
  include Vanity::Rails::Dashboard
  layout false  # exclude this if you want to use your application layout
  skip_before_filter :authenticate_user!, only: 
  						[:add_participant, :image]
  before_filter :require_admin!, except: 
  						[:add_participant, :image]  						

end
