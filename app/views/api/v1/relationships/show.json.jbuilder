json.cache! ['v1', @relationship], expires_in: 1.day do  
  json.partial! 'relationship', relationship: @relationship
end  