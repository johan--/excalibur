json.cache! ['v1', @business], expires_in: 1.day do  
	json.id @business.id
	json.name @business.name
	json.anno @business.anno
	json.founding_size @business.founding_size
	json.about @business.about
	json.offline_presence_types @business.offline_presence_types
	json.online_presence_types @business.online_presence_types
	json.starter @business.team.starter
end  