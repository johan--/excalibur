class Tenders::BuildController < ApplicationController
  include Wicked::Wizard
  steps *Tender.form_steps

  # steps :fill_proposal, :fill_profile, :upload_docs

  def show
    @tender = Tender.find(params[:tender_id])
    case step
    when :fill_profile
      @user = current_user
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