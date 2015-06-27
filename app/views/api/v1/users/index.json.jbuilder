json.users @users do |user|
	json.id user.id
	json.email user.email
	json.full_name user.full_name
end