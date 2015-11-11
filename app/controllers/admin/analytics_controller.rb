class Admin::AnalyticsController < Admin::BaseController

  def visits
  	@visits = Visit.all.order(:started_at).page params[:page]
    @daily_visits = @visits.group_by_day_of_week(:started_at, format: "%a").count
    @recent_visits = @visits.group_by_week(:started_at, last: 8, format: "%y%W").count  	
  end

  def events
    @events = Ahoy::Event.all.order(:time).page params[:page]
    @blog_events = Ahoy::Event.blog.order(:time).page params[:page]
    @user_events = Ahoy::Event.user.order(:time).page params[:page]
    @document_events = Ahoy::Event.document.order(:time).page params[:page]
    @proposal_events = Ahoy::Event.proposal.order(:time).page params[:page]
    @simulation_events = Ahoy::Event.simulation.order(:time).page params[:page]
    @simulation_events = Ahoy::Event.simulation.order(:time).page params[:page]
    @users = User.all
    @misc_events = Ahoy::Event.all.not(blog).not(user).not(document).not(proposal).not(simulation)
    @admin_layout = true  	
  end

end