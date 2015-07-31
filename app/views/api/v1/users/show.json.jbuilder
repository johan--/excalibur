json.cache! ['v1', @user], expires_in: 1.day do
	json.id @user.id
	json.email @user.email
	json.name @user.name
	json.created_at @user.created_at
	json.updated_at @user.updated_at
end  