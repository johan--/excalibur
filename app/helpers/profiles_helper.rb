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

end
