json.cache! ['v1', @user], expires_in: 1.day do  
  json.partial! 'user', user: @user
end  