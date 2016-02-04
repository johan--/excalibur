module ImagesHelper
	def cloudinary_thumbnail_options
		{ :type => :private, :width => 350, :height => 350, quality: 55, 
			:crop => :pad, :gravity => :north, format: :jpg, 
			class: "panel-image-preview" }
	end

	def cloudinary_zoomed_options
		{ :type => :private, :width => 1000, :height => 1000, quality: 100, 
			:crop => :pad, :gravity => :north, format: :jpg,
			 class: "panel-image-preview" }
	end

	def cloudinary_photo_options(type)
	  if type == 'private'
		{ :type => :private, :width => 175, :height => 175, quality: 100, 
			:crop => :scale, format: :jpg, 
			class: "panel-image-preview" }
	  else
		{ :type => :upload, :width => 175, :height => 175, quality: 100, 
			:crop => :scale, format: :jpg, 
			class: "panel-image-preview" }	  	
	  end
	end

	def house_photo_options(size)
		if size == 'zoom'
			{ :type => :private, :width => 700, :height => 500, quality: 100, 
			:crop => :scale, format: :jpg, 
			class: "img-responsive" }
		else
			{ :type => :private, :width => 175, :height => 175, quality: 100, 
			:crop => :scale, format: :jpg, 
			class: "img-responsive" }			
		end
	end

	def cloudinary_thumb_options(type)
	  if type == 'private'
		{ :type => :private, :width => 60, :height => 60, quality: 70, 
			:crop => :scale, format: :jpg, 
			class: "panel-image-preview" }
	  else
		{ :type => :upload, :width => 60, :height => 60, quality: 70, 
			:crop => :scale, format: :jpg, 
			class: "panel-image-preview" }	  	
	  end
	end

	def user_thumb_options(type, string)
		type = type.to_sym
		{ :type => type, :width => 80, :crop => :scale, format: :jpg,
		class: "#{string}" }
	end

	def user_lg_options(type, string)
		type = type.to_sym
		{ :type => type, :width => 400, :height => 300, 
			:crop => :scale, format: :jpg, class: "#{string}" }
	end


  def render_house_display(house, string)
    if house.avatar.blank?
      cl_image_tag('asset/2000px-House_Silhouette', user_lg_options('', string))
    else
      cl_image_tag(house.avatar, user_lg_options('private', string))
    end
  end

  def render_house_display(house, string)
    if house.avatar.blank?
 	  image_tag('http://res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_175,w_175/v1452508512/asset/2000px-House_Silhouette.png',
 	  	class: 'img-responsive thumbnail')
    else
      cl_image_tag(house.avatar, user_lg_options('private', string))
    end
  end  
end