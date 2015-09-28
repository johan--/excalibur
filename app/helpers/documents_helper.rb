module DocumentsHelper

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

end