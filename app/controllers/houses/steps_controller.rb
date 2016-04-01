class Houses::StepsController < ApplicationController
  include Wicked::Wizard
  before_filter :inside_app
  steps *House.form_steps

  def show
    @house = House.friendly.find(params[:house_id])
    @step = step
    @previous = previous_step

    case step
      when 'place'
        @disable_previous = true
        @disable_next = true if @house.form_step.nil? 
      when 'characteristics'
        @disable_next = true if @house.form_step == previous_step || @house.form_step == step
      when 'pictures'
        @uploading = true
        @no_avatar = true if @house.avatar.nil?
        @disable_next = true if @no_avatar || @house.form_step == step
      when 'situations'
        @disable_next = true if @house.form_step == step
    end    
    render_wizard
  end


  def update
    @house = House.friendly.find(params[:house_id])
    @house.form_step = next_step unless Wicked::LAST_STEP
    @house.form_step = 'done' if Wicked::LAST_STEP

    if @house.update(house_params(step))
      flash[:notice] = 'Data telah disimpan, lanjutkan'
    else
      flash[:warning] = 'Data gagal disimpan, mohon ulangi'
    end

    render_wizard @house
  end

private

  def house_params(step)
    permitted_attributes = case step
      when "place"
        [:complex, :address, :city, :province]
      when "characteristics"
        [:category, :bedrooms, :bathrooms, :level, :garages, 
          :lot_size, :property_size]
      when "pictures"
        [:photos_attributes => [:id, :signature, :created_at, 
        :tags, :bytes, :type, :etag, :url, :secure_url, 
        :original_filename],
        photos: [] 
        ]
      when "situations"
        [:anno, :price, :for_sale, :vacant,
          :mortgage_period_left, :outstanding_mortgage]
      end

    params.require(:house).permit(:form_step, permitted_attributes).merge(
      form_step: step)
  end  

  def finish_wizard_path
    house_path
  end  
end