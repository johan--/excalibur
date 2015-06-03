class RostersController < ApplicationController
	before_action :set_firm
  before_action :set_roster, only: [:edit, :update, :destroy]

  def index
    @rosters = @firm.rosters
  end

  def new
    @roster = Roster.new
  end

  def edit
  end

  def create
    @roster = Roster.new(roster_params)

      if @roster.save
        redirect_to home_path(@firm)
        flash[:notice] = 'Pengguna berhasil ditambah ke dalam tim'
      else
        render :new
      end
  end

  def update
    if @roster.update(roster_params)
      redirect_to home_path(@firm)
      flash[:notice] = 'Anggota tim berhasil dikoreksi'
    else
      render :edit 
    end
  end

  def destroy
    @roster.destroy
    respond_to do |format|
      format.html { redirect_to home_path(@firm), notice: 'Hak anggota tim berhasil dihapus' }
      format.json { head :no_content }
    end
  end



  private

  def set_roster
    @roster = @firm.rosters.find(params[:id])
  end

  def roster_params
    params.require(:roster).permit(
      :role, :status, :user_email, :user_phone, :user_id, :firm_id,
      :password, :password_confirmation, :first_name, :last_name
    )
  end

end