# class API::V1::BusinessesController < API::V1::BaseController
#   before_action :check_user_type, only: [:create, :update]
#   before_action :set_business, only: [:show, :update, :destroy]

#   def_param_group :business do
#     param :business, Hash, required: true do
#       param :name, String, "Name of the business", required: true
#       param :anno, Integer, "Id of the bidder as a polymorphic owner", required: true
#       param :founding_size, Integer, "Number of founders or owners related in integer", required: true
#       param :starter_email, String, "Email address of the user who creates the business", required: true
#       param :about, String, "Summary of the business profile", required: true
#       param :offline_presence_types, Array, "Array of Strings that describe the physical infrastructure of the business"
#       param :online_presence_types, Array, "Array of Strings that describe the virtual infrastructure of the business"
#     end
#   end

#   api :GET, "/businesses", "Show a bunch of businesses"
#   description "Show a bunch of businesses that are related to current_user"
#   def index
#   	@businesses = current_user.businesses.page(params[:page]).per(5)
#   end

#   api :GET, "/businesses/:id", "Show attributes of a single business"
#   description "Show a single business with its related team and rosters"
#   def show
#   end

#   api :POST, "/businesses", "Create a new business"
#   description "Create a new business plus team and its rosters"
#   param_group :business
#   def create
#     @business = Business.new(business_params)
    
#     if @business.save
#       render json: @business, status: 201, message: 'Bisnis berhasil didaftarkan'
#     else
#       render json: {error: "Bisnis gagal dibuat"}, status: 422
#     end
#   end

#   api :PUT, "/businesses/:id", "Update an existing business"
#   description "Update the profile of an exisiting business"
#   param_group :business
#   def update        
#     if @business.update(business_params)
#       render json: @business, status: 200, message: 'Profil bisnis berhasil diperbaharui'
#     else
#       render json: {error: 'Profil bisnis gagal diperbaharui'}, status: 422
#     end
#   end

#   # def destroy
#   #   @business.destroy
#       # render json: {error: "Bisnis berhasil dihapus"}, status: 204
#   # end

# private
#   def check_user_type
#     if current_user.investor? && !current_user.founder?
#       render json: { errors: "Kamu tidak terdaftar sebagai pengusaha" }, status: :unauthorized
#     end
#   end

#   def set_business
#     # @business = Business.friendly.find(params[:id])
#     @business = current_user.businesses.friendly.find(params[:id])
#   end

#   def business_params
#     params.require(:business).permit(
#       :name, :slug,
#         :anno, :founding_size, :about,
#         :online_presence_types => [], :offline_presence_types => []
#     )
#   end

# end