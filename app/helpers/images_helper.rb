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

end