module API
  module V1
	class RelationshipsController < ApplicationController

	  def index
	  	@relationships = current_user.relationships.by_user(current_user.id)
	  end

	  def show
	  	@relationship = Relationship.find(params[:id])
	  end
		
	  def create
		@relationship = Relationship.new(relationship_params)

        if @relationship.save
          render json: @relationship, status: 201, message: 'Hubungan berhasil dibuat'
        else
          render json: {error: "Hubungan gagal dibuat"}, status: 422
        end
	  end

	  def destroy
		@relationship = Relationship.find(params[:id])
		@relationship.destroy

        if @relationship.destroy
          render json: {}, status: 200
        else
          render json: {error: "Hubungan gagal dihapus"}, status: 422
        end
	  end

		private

		def relationship_params
			params.require(:relationship).permit(
				:followed_id, :followed_type, :follower_id
			)
		end

	end
  end
end