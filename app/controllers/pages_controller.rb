class PagesController < ApplicationController
  layout 'application'
  include HighVoltage::StaticPage
  skip_before_filter :authenticate_user!
  before_filter :set_as_static
  before_filter :set_instance_variable
  
# link with /pages in landing
private

  def set_instance_variable
    case params[:id]
    when 'landing'
      @category = "registration"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { page: 'root page', referrer: request.referrer, device: request.variant } )
      end
    when 'kepemilikan'
      @category = "ownership"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { page: 'house purchase', referrer: request.referrer, device: request.variant } )
      end      
    when 'how_it_works'
      @category = "funding"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { page: 'property investment', referrer: request.referrer, device: request.variant } )
      end
    else
    end
  end
end