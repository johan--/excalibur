module HousesHelper

  def mortgage_left(house)
    if house.outstanding_mortgage.nil? || house.outstanding_mortgage.blank?
      return '0'
    else
      return house.outstanding_mortgage
    end
  end


  def show_footer_link_for_house(house)
    unless house.input_unfinished?
      content_tag(:li) do
        link_to "Lihat", house_path(house)
      end
    end
  end

  def edit_footer_link_for_house(house)
    if current_user && house.access_granted?(current_user)
      content_tag(:li) do
        link_to "Edit", edit_url_for_house(house), id: 'house-edit'
      end
    end
  end

  def edit_url_for_house(house)
    if house.input_unfinished?
      if house.form_step.nil?
        destination = house_step_path(house, house.form_steps.first)
      else
        destination = house_step_path(house, house.form_step)
      end
    else
     destination = edit_house_path(house)
   end
   destination
  end

  def fundraising_footer_link(house)
    unless house.input_unfinished?
      content_tag(:li) do
        link_to fundraising_purchase_url_for_house(house) do
          content_tag(:span, class: 'text-danger') do
            embedded_svg('spark-10-writing.svg', class: 'svg-icon') + 'Buat Proposal'
          end
        end

      end
    end    
  end

  def fundraising_purchase_url_for_house(house)
    new_house_tender_path(house, intent: 'fundraising')
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
      cl_image_tag(house.placeholder_id, house_tender_options(string))
    else
      cl_image_tag(house.display_picture.path, house_tender_options(string))
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

  def sale_label(house)
    content_tag(:span, 'Dijual', class: 'label label-default')  if house.for_sale?
  end

  def rent_label(house)
    content_tag(:span, 'Disewa', class: 'label label-default')  if house.for_rent?
  end

  def vacant_label(house)
    content_tag(:span, 'Kosong', class: 'label label-default')  if house.vacant?
  end  
end