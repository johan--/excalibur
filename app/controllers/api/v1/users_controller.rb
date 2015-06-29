class API::V1::UsersController < API::V1::BaseController
  skip_before_action :authenticate_with_token!, only: [:create, :show]


  api :GET, "/users", "List all player users"
  description "List all the users that are of players category"
  def index
    @users = User.players.all
  end

  api :GET, "/users/:id", "Show attributes of an user"
  description "Show attributes of a user"
  def show
	  @user = User.find(params[:id])
  end

  api :POST, "/users", "Create a new player user"
  description "Create user with a player as the category"
  param :user, Hash do
    param :email, String, "Email of the user", required: true
    param :password, String, "Password of the user", required: true
    param :password_confirmation, String, "Password confirmation of the user", required: true
    param :full_name, String, "Name of the user", required: true
    param :category, Integer, "Category of the user, 1=player; 2=operator", required: true
  end
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201, message: 'Pengguna berhasil dibuat'
    else
      render json: { errors: 'Pengguna gagal dibuat' }, status: 422
    end
  end

  api :PUT, "/users/:id", "Update a user, player or operator"
  description "Update a user's attributes"
  param :user, Hash do
    param :email, String, "Email of the user"
    param :current_password, String, "Current password of the user", required: true
    param :password, String, "New Password of the user"
    param :password_confirmation, String, "New Password confirmation of the user"
    param :full_name, String, "Name of the user"
    param :category, Integer, "Category of the user, 1=player; 2=operator"
  end
  def update
    @user = User.find(params[:id])

  	if @user.update(user_params)
  	  render json: @user, status: 200, message: 'Pengguna berhasil dikoreksi'
  	else
  	  render json: { errors: 'Pengguna gagal dikoreksi' }, status: 422
  	end
  end

  private

    def user_params
      params.require(:user).permit(
      	:email, :password, :password_confirmation, 
      	:full_name, :category
      )
    end

end