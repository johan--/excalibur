class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  before_action :user_layout
  
  # GET /teams
  # GET /teams.json
  def index
    @teams = type_class.all
    @team_search = Team.search(search_params)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = type_class.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    set_team
    @member = @team.rosters.build(
    rosterable: current_user, role: 2, state: "menunggu")

      if @member.save
        redirect_to root_path(subdomain: "blog")
        flash[:notice] = 'Tunggu konfirmasi dari moderator bisnis ini'
      else
        render :new 
        flash[:warning] = 'Kamu gagal bergabung, coba lagi'
      end
  end


  private
    def type 
        Team.types.include?(params[:type]) ? params[:type] : "Team"
    end

    def type_class 
        type.constantize 
    end

    def set_type
       @type = type 
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = type_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      # params.require(:team).permit(:type, :name, :starter_email)
      params.require(type.underscore.to_sym).permit(
        :type, :name, :starter_email
      )
    end
end
