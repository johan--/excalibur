class GroupsController < ApplicationController

  def show
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)

    if @group.save
      flash[:notice] = 'Grup berhasil dibuat'
      redirect_to @group
    else
      redirect_to user_root_path
    end
  end


private
  def set_group
    @group = Group.friendly.find(params[:id])
  end

  # def find_starter
  #   if params[:business_id]
  #     @starter = Business.friendly.find(params[:business_id])
  #   elsif params[:user_id]
  #     @starter = User.friendly.find(params[:user_id])
  #   end
  # end

  def tender_params
    params.require(:tender).permit(
      :name, :type, :details 
    )
  end
end