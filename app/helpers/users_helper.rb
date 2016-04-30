module UsersHelper
	def render_user_auth_choice(user)
	  if user.using_omniauth?
	  	  content_tag(:i, '', class: "fa fa-#{user.auth_with}") +
	  	  " Kamu menggunakan akun #{user.auth_with}"
	  else
	  	  content_tag(:i, '', class: "fa fa-square-o") +
	  	  " Kamu menggunakan akun Kapiten"
	  end
	end

	def render_user_thumb(user, string)
	  if user.using_omniauth?
	  	if user.auth_with == 'facebook'
	  		image_tag(user.avatar + "?type=square", class: string)
	  	else
	  		image_tag(user.avatar, class: string)
	  	end
	  else
	  	if user.avatar.blank?
	      cl_image_tag('asset/default-avatar-sm', user_thumb_options('upload', string))
	  	else
	      cl_image_tag(user.avatar, user_thumb_options('private', string))
	  	end
	  end
	end

	def render_user_display(user, string)
  	  if user.avatar.blank?
    	cl_image_tag('asset/default-avatar-sm', user_lg_options('upload', string))
  	  else
    	cl_image_tag(user.avatar, user_lg_options('private', string))
  	  end
	end

	def determine_user_display(user, string)
	  if user.using_omniauth?
	  	if user.auth_with == 'facebook'
	  		image_tag(user.avatar + "?type=large", class: string)
	  	else
	  		image_tag(user.avatar, class: string)
	  	end
	  else
	  	render_user_display(user, string)
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