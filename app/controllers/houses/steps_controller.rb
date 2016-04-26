class Houses::StepsController < ApplicationController
  include Wicked::Wizard
  before_filter :inside_app
  steps *House.form_steps

  def show
    @house = House.friendly.find(params[:house_id])
    @step = step
    @previous = previous_step
    @status = true if @house.form_step != 'done'

    case step
      when 'place'
        no_previous 
        no_next if @house.form_step.nil? 
      when 'characteristics'
        no_next if @house.form_step == previous_step || @house.form_step == step
      when 'situations'
        no_next if @house.form_step == previous_step || @house.form_step == step
      when 'pictures'
        different_form
        @no_avatar = true if @house.photos.empty?
        no_next if  @house.form_step == step
      when 'proposal'
        different_form
        no_previous 
        no_next
        @tender = Tender.new
        @category = 'fundraising'
        @aqad = "Musyarakah Mutanaqishah"
        @asset_type = 'House'
        @asset_id = @house.slug
        @disable_link = true
    end    
    render_wizard
  end


  def update
    @house = House.friendly.find(params[:house_id])
    @house.assign_attributes(house_params(step))

    if @house.valid?
      unless @form_step == 'done'
        if next_step == Wicked::FINISH_STEP || 'proposal'
          @house.form_step = 'done' 
        else
          @house.form_step = next_step
        end
      end

      @house.save

      if @house.form_step == 'done'
        flash[:notice] = 'Terima kasih, data sudah lengkap'
      else
        flash[:notice] = 'Data telah disimpan, lanjutkan'
      end

    else 
      @house.errors
      flash[:warning] = 'Data gagal disimpan, mohon ulangi'
      render_wizard @house
    end

    if step == 'pictures'
       if params[:proposed] == true || 'true'
        render_wizard @house
      else
        redirect_to finish_wizard_path
      end
    else
      render_wizard @house
    end    
  end


private

  def house_params(step)
    permitted_attributes = case step
      when "place"
        [:complex, :address, :city, :province]
      when "characteristics"
        [:category, :bedrooms, :bathrooms, :level, :garages, 
          :lot_size, :property_size]
      when "situations"
        [:anno, :price, :for_sale, :vacant,
          :mortgage_period_left, :outstanding_mortgage]
      when "pictures"
        [:proposed, :photos_attributes => [:id, :signature, :created_at, 
        :tags, :bytes, :type, :etag, :url, :secure_url, 
        :original_filename],
        photos: [] 
        ]
      end

    params.require(:house).permit(:form_step, permitted_attributes).merge(
      form_step: step)
  end  

  def finish_wizard_path
    house_path(@house)
  end  

  def no_next
    @disable_next = true
  end

  def no_previous
    @disable_previous = true
  end

  def different_form
    @independent = true
  end
end