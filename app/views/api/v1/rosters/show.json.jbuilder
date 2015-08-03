json.cache! ['v1', @roster], expires_in: 1.day do  
	json.id @roster.id
	json.state @roster.state
	json.role @roster.role

	json.team @roster.team do |team|
    	json.id team.id
    	json.teamable_type team.teamable_type
    	json.teamable_id team.teamable_id
    	json.team_name team.name
	end

	json.rosterable @roster.rosterable do |rosterable|
    	json.(rosterable, :id, :rosterable_type, :rosterable_id)
	end
end  