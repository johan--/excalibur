class WikiPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:all, :show, :compare]
  # before_filter :disable_background
  before_action :wiki_layout
  before_action :all_pages, only: :show

  acts_as_wiki_pages_controller


private
  def wiki_layout
    @wiki_layout = true
    # @recents = Post.recent
  end

  def permitted_page_params
    params.require(:page).permit(
      :title, :content, :comment, :content_md
    )
  end

  def all_pages
  	@pages = WikiPage.all
  end

  def history_allowed?
  	true if current_user.try(:admin?)
  end

  def edit_allowed?
  	true if current_user.try(:admin?)
  end

  def destroy_allowed?
  	true if current_user.try(:admin?)
  end  
end