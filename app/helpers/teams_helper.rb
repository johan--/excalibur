module TeamsHelper
	def sti_team_path(type = "team", team = nil, action = nil)
	  send "#{format_sti(action, type, team)}_path", team
	end

	def format_sti(action, type, team)
	  action || team ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
	end

	def format_action(action)
	  action ? "#{action}_" : ""
	end
end
