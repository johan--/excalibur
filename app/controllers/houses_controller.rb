class HousesController < ApplicationController
  before_filter :inside_app
  
  def index
  	@houses = House.all
  	@tender = Tender.new
  end

  def show
  	@house = House.friendly.find(params[:id])
  	@photos = @house.photos
	# @position = @house.to_json
  end





end