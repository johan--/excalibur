# class API::V1::RostersController < API::V1::BaseController
#   before_action :set_roster, only: [:show, :update, :destroy]

#   def_param_group :roster do
#     param :roster, Hash, required: true do
#       param :role, Integer, "the level of role, from 0-3, with 0 having the biggest authority", required: true
#       param :rosterable_id, Integer, "Id of the object as the roster, can be User or Document", required: true
#       param :rosterable_type, String, "Type of the object as the roster, can be User or Document", required: true
#       param :state, String, "State of the membership; aktif, skors, berhenti"
#       param :team_id, Integer, "Id of the team, which also belongs to group models, such as Business", required: true
#     end
#   end

#   api :GET, "/rosters/:id", "Show attributes of a single membership/roster"
#   description "Show a single roster, can be made of User, Document, etc"
#   def show
#   end

#   api :POST, "/rosters", "Create a roster/membership for a team"
#   description "Create a roster/membership for a team"
#   param_group :roster
#   def create
#   	@roster = Roster.new(roster_params)
#     if @roster.save
#       render json: @roster, status: 201, message: 'Keanggotaan berhasil dibuat'
#     else
#       render json: {error: "Keanggotaan gagal dibuat"}, status: 422
#     end  	
#   end

#   api :PUT, "/rosters/:id", "Update a membership of a team"
#   description "Update a membership of a team"
#   param_group :roster
#   def update
#     if @roster.update(roster_params)
#       render json: @roster, status: 200, message: 'Tawaran berhasil diperbaharui'
#     else
#       render json: {error: 'Tawaran gagal diperbaharui'}, status: 422
#     end
#   end

#   def destroy
#     @roster.destroy
#     render json: {error: "Keanggotaan berhasil dihapus"}, status: 204  	
#   end


# private
#   def set_roster
# 	  @roster = Roster.find(params[:id])
#   end

#   def roster_params
#   	params.require(:roster).permit(
#   	  :rosterable_type, :rosterable_id, :role, :state, :team_id
#   	)
#   end

# end