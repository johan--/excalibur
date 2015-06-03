class Biz::BaseController < ApplicationController

  before_filter :require_operator!
  before_action :set_firm
  before_action :firm_layout

  def show
  	
  end

  def bookings
  end

  def settings
  end

  # def new
  #   @firm = Firm.new
  # end

  def edit
  end


  # def create
  #   @firm = Firm.new(firm_params)

  #   respond_to do |format|
  #     if @firm.save
  #       format.html { redirect_to @firm, notice: 'Firm was successfully created.' }
  #       format.json { render :show, status: :created, location: @firm }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @firm.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      if @firm.update(firm_params)
        format.html { redirect_to @firm, notice: 'Firm was successfully updated.' }
        format.json { render :show, status: :ok, location: @firm }
      else
        format.html { render :edit }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firm
      @firm = Firm.find(current_user.find_firm) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firm_params
      params.require(:firm).permit(
        :name, :region, :city, :address, :phone
      )
    end
end