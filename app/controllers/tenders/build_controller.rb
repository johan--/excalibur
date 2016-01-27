class Tenders::BuildController < ApplicationController
  include Wicked::Wizard

  steps :add_aqad, :add_tenderable, :finish_up

  def show
    @tender = Tender.find(params[:tender_id])
    case step
    when :add_tenderable
      @stocks = Stock.initials.tradeables
    end    
    render_wizard
  end


  def update
    @tender = Tender.find(params[:tender_id])
    params[:tender][:draft] = 'no' if step == steps.last
    @tender.update_attributes(params[:tender])
    render_wizard @tender
  end


  def create
    @tender = Tender.create
    redirect_to wizard_path(steps.first, :tender_id => @tender.id)
  end
end