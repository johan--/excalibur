class API::V1::RelationshipsController < API::V1::BaseController

  api :GET, "/relationships", "List of relationships made by current user"
  description "Show all relationships where the current user is the follower"
  def index
  	# @relationships = Relationships.by_user(@current_user.id)
    @relationships = @current_user.relationships
  end

  api :GET, "/relationships/:id", "Show a relationship"
  description "Show attributes of a relationship"
  def show
  	@relationship = @current_user.relationships.find(params[:id])
  end

  api :POST, "/relationships", "Create a new relationship"
  description "Create a new relationship with the current user as the follower"
  param :relationship, Hash, required: true do
    param :followed_id, Integer, "Id of the followed user", required: true
    param :followed_type, String, "Followed type, a user or a venue", required: true
  end
  def create
	  @relationship = @current_user.relationships.build(relationship_params)

    if @relationship.save
      render json: @relationship, status: 201, message: 'Hubungan berhasil dibuat'
    else
      render json: {error: "Hubungan gagal dibuat"}, status: 422
    end
  end

  api :DELETE, "/relationships/:id", "Destroy a relationship (unfollow)"
  description "Destroy a relationship of the current user"
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
			:followed_id, :followed_type#, :follower_id
		)
	end

end
