module UsersHelper

	def user_authority(user)
		if user.client? && !user.financier?
			return "Klien"
		elsif user.financier? && !user.client?
			return "Pendana"
		else
			return "Klien & Pendana"
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