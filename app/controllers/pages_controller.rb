class PagesController < ApplicationController
  layout 'application'
  include HighVoltage::StaticPage
  skip_before_action :authenticate_user!
  before_filter :set_as_static
  before_filter :set_instance_variable
  

private
  def set_instance_variable
    case params[:id]
    when 'landing'
      @category = "registration"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { 
          distinct_id: request.uuid }
        )
      end
    when 'kepemilikan'
      @category = "ownership"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { 
          distinct_id: request.uuid }
        )
      end      
    when 'how_it_works'
      @category = "funding"
      unless current_user.present?
        meta_events_tracker.event!(:visit, :landing, { 
          distinct_id: request.uuid }
        )
      end
    else
    end
  end
end