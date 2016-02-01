module UsersHelper

	def render_avatar_for(user, string)
  	  if user.avatar.blank?
    	cl_image_tag('asset/default-avatar-sm', user_thumb_options('upload', string))
  	  else
    	cl_image_tag(user.avatar, user_thumb_options('private', string))
  	  end
	end

	# Failed, undefined method each for String
	# def user_career(user)
	# 	unless user.work_experience.nil? || user.work_experience == ''
	# 		user.work_experience.each do |exp|
	# 			content_tag(:span, exp, class: "tags")
	# 		end
	# 	end
	# end

end