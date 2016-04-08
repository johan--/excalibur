module HousesHelper

 def edit_link(house)
   if house.input_unfinished?
      if house.form_step.nil?
        destination = house_step_path(house, house.form_steps.first)
      else
        destination = house_step_path(house, house.form_step)
      end
   else
     destination = edit_house_path(house, house.form_step)
   end

   link_to destination, data: {toggle: 'tooltip', 
    placement: 'top', original_title: 'Edit'} do
      content_tag(:i, '', class: "fa fa-pencil")
   end
 end

  def show_link(house)
    link_to house_path(house), data: {toggle: 'tooltip', 
      placement: 'top', original_title: 'Telusuri'} do
        content_tag(:i, '', class: "fa fa-search-plus")
    end  	
  end

  def render_lg_house_display(house, string)
    if house.display_picture.blank?
      image_tag('//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_300,w_450/v1452508512/asset/2000px-House_Silhouette.png')
    else
      cl_image_tag(house.display_picture.path, house_avatar_options(string))
    end
  end

  def render_house_display(house, string)
    if house.display_picture.blank?
    image_tag('//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_160,w_240/v1452508512/asset/2000px-House_Silhouette.png',
      class: 'img-responsive thumbnail')
    else
      cl_image_tag(house.display_picture.path, house_avatar_options(string))
    end
  end  

  def render_house_display_for_tender(house, string)
    if house.display_picture.blank?
    image_tag('//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_200,w_300/v1452508512/asset/2000px-House_Silhouette.png',
      style: 'width: 100%;')
    else
      cl_image_tag(house.display_picture.path, house_tender_options('private', string))
    end
  end    

  def house_tender_options(string)
    { :width => 300, :height => 200, 
      :crop => :lfill, gravity: :center, class: "#{string}" }
  end  

  def house_avatar_options(string)
  { :width => 500, :height => 300, 
    :crop => :lfill, gravity: :center, class: "#{string}" }
  end

  def house_header_options
  { :width => 1200, :height => 500, :crop => :lfill, 
    gravity: :center, quality: 100 }
  end  
end