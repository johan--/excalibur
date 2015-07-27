module ProfilesHelper

	def sti_profile_path(category = "profile", profile = nil, action = nil)
	  send "#{format_sti(action, category, profile)}_path", profile
	end

	def format_sti(action, category, profile)
	  action || profile ? "#{format_action(action)}#{category.underscore}" : "#{category.underscore.pluralize}"
	end

	def format_action(action)
	  action ? "#{action}_" : ""
	end

	def profile_action_heading
		if current_page?(new_company_profile_path) || current_page?(new_user_profile_path)
			return "Buat Profil"
		else
			return "Edit Profil"
		end
	end

	def profil_type(category)
		if category == 'CompanyProfile'
			return "Bisnis"
		elsif category == 'UserProfile'
			return "Pengguna"
		end
	end

end
