class RelationshipsController < ApplicationController

	def create
		@followed = Venue.find(relationship_params[:followed_id])
		current_user.follow!(@followed)
		# current_user.follow!(params[:followed_id], params[:followed_type])
		respond_to do |format|
			format.html { redirect_to home_path, notice: "Berhasil di Follow" }
			format.js
		end
	end

	def destroy
		@relationship = Relationship.find(params[:id])
		@relationship.destroy
		respond_to do |format|
			format.html { redirect_to home_path }
			format.js
		end
	end

	private

	def relationship_params
		params.require(:relationship).permit(
			:followed_id, :followed_type)
	end

end