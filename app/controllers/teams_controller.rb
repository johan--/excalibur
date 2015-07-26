class TeamsController < ApplicationController
  include TeamSti
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_type
  before_action :user_layout
  
  def index
    @teams = type_class.all
    @team_search = Team.search(search_params)
  end

  def show
  end

  def new
    @team = type_class.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @team = type_class.new(team_params)
    @team.starter_email = current_user.email

    respond_to do |format|
      if @team.save
        format.html { redirect_to user_root_path, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to user_root_path, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to user_root_path, notice: 'Team was successfully destroyed.' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = type_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(type.underscore.to_sym).permit(
        :type, :name, :starter_email, 
        details: [:public, :last_education, :marital_status, 
          :industry_experience, :work_experience]
      )
    end
end
