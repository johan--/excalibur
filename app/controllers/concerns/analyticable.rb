module Analyticable
  extend ActiveSupport::Concern

  def current_browser_id
    request.uuid
  end
  
  def meta_events_tracker
    if user_signed_in?
      user_id = current_user.id
    else
      user_id = current_browser_id
    end
    @meta_events_tracker ||= MetaEvents::Tracker.new(user_id, request.remote_ip)
  end

  def mixpanel_tracker
    Mixpanel::Tracker.new(ENV["MIX_TOK"]) 
  end

end