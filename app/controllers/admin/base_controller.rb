class Admin::BaseController < ApplicationController
  before_filter :require_admin!
  before_action :disable_background

  def index
    @last_signups = User.last_signups(10)
    @last_signins = User.last_signins(10)
    @user_count = User.count
    @post_count = Post.count
    @doc_count = Document.count
    @tender_count = Tender.count
  end

  def analytics
    @admin = User.group(:admin).count
  end

  def inbox
  end

private


end
