class Biz::RostersController < Biz::BaseController
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
    @roster.rosterable = @firm
    @roster.state = 'aktif'

      if @roster.save
        redirect_to biz_rosters_path
        flash[:notice] = 'Pengguna berhasil ditambah ke dalam tim'
      else
        redirect_to biz_rosters_path
        flash[:warning] = 'Pengguna gagal ditambah ke dalam tim'
      end
  end

  def update
    if @roster.update(roster_params)
      redirect_to biz_rosters_path
      flash[:notice] = 'Anggota tim berhasil dikoreksi'
    else
      render :edit 
    end
  end

  def destroy
    @roster.destroy
    respond_to do |format|
      format.html { redirect_to biz_root_path(@firm), notice: 'Hak anggota tim berhasil dihapus' }
      format.json { head :no_content }
    end
  end



  private

  def set_roster
    @roster = @firm.rosters.find(params[:id])
  end

  def roster_params
    params.require(:roster).permit(
      :role, :state, :user_email, :user_phone, :user_id, :firm_id,
      :password, :password_confirmation, :full_name
    )
  end

end