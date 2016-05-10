module UsersHelper
	def render_user_auth_choice(user)
	  if user.using_omniauth?
	  	  content_tag(:i, '', class: "fa fa-#{user.auth_with}") +
	  	  " Kamu masuk menggunakan akun #{user.auth_with}"
	  else
	  	  content_tag(:i, '', class: "fa fa-info-circle") +
	  	  " Kamu masuk menggunakan akun SiKapiten"
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
	#   # if user.work_experience.nil? || user.work_experience == ''
	#   # 	content_tag(:p, "belum diisi") 
	#   # else
	#   	# user.work_experience.split(";").each{|split| "<p>#{split}</p>" }.join("\n")
	# 	# output = ''
	# 	user.work_experience.split(";").each do |w|
	# 	  return content_tag(:p, w)
	# 	end
	# 	# content_tag(:p, output) 
	#   # end
	# end

	def user_education(user)
	  education = if user.last_education.nil? then 'belum diisi' else user.last_education end
	  content_tag(:p, education, id: 'user-education')
	end

	def user_occupation(user)
	  occupation = if user.occupation.nil? then 'belum diisi' else user.occupation end
	  content_tag(:p, occupation, id: 'user-occupation')
	end

	def user_family(user)
	  if user.marital_status.nil?
	  	text = 'belum diisi'
	  else
		text = "#{user.marital_status} dan memiliki #{user.number_dependents} individu sebagai tanggungan"
	  end
	  content_tag(:p, text, id: 'user-family')
	end

	def user_bio(user)
	  bio = if user.about.nil? then 'belum diisi' else user.about end
	  content_tag(:p, bio, id: 'user-bio')
	end	
end