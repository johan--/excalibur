class WikiPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:all, :show, :compare]
  # before_filter :disable_background
  # skip_before_action :setup_page, only: :show
  before_action :wiki_layout
  before_action :all_pages, only: :show
  after_action  :track_wiki_view, only: :show
  after_action  :track_wiki_landing, only: :all

  acts_as_wiki_pages_controller


private
  def wiki_layout
    @wiki_layout = true
    # @recents = Post.recent
  end

  def track_wiki_view
    unless current_user.present? && current_user.admin?
      meta_events_tracker.event!(:visit, :blogpost, { title: @page.title, category: 'wiki', referrer: request.referrer } )
    end    
  end

  def track_wiki_landing
    unless current_user.present? && current_user.admin?
      meta_events_tracker.event!(:visit, :blog, { page: 'wiki page', referrer: request.referrer } )
    end    
  end

  def permitted_page_params
    params.require(:page).permit(
      :title, :content, :comment, :content_md, :thumbnail, :tags
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