class HousesController < ApplicationController
  before_action :user_layout
  
  def index
  	@houses = House.all
  end

  def show
  	@house = House.friendly.find(params[:id])
  	@photos = @house.photos
	# @position = @house.to_json
  end





end