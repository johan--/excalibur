module PostsHelper
  
  def cly_sm_header_options
  	{ :width => 300, :height => 150, :crop => :scale, format: :jpg }
  end
  def cly_lg_header_options
  	{ :width => 750, :height => 350, :crop => :scale, format: :jpg }
  end

end