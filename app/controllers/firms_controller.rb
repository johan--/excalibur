class FirmsController < ApplicationController
  before_action :set_firm, only: [:show, :edit, :update, :destroy, 
                                  :all_reservations, :analysis]
  before_action :require_admin, only: [:destroy]
  before_action :firm_layout
  # GET /firms
  # GET /firms.json
  # def index
  #   @firms = Firm.all
  # end

  # GET /firms/1
  # GET /firms/1.json
  def show
    # @reserve_by_date = @firm.reservations.group_by { |res| res.date_reserved }
  end

  # GET /firms/new
  def new
    @firm = Firm.new
  end

  # GET /firms/1/edit
  def edit
  end

  # POST /firms
  # POST /firms.json
  def create
    @firm = Firm.new(firm_params)

    respond_to do |format|
      if @firm.save
        format.html { redirect_to @firm, notice: 'Firm was successfully created.' }
        format.json { render :show, status: :created, location: @firm }
      else
        format.html { render :new }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /firms/1
  # PATCH/PUT /firms/1.json
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

  # DELETE /firms/1
  # DELETE /firms/1.json
  def destroy
    @firm.destroy
    respond_to do |format|
      format.html { redirect_to firms_url, notice: 'Firm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_firm
      @firm = Firm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def firm_params
      params.require(:firm).permit(
        :name, :region, :city, :address, :phone
      )
    end
end
