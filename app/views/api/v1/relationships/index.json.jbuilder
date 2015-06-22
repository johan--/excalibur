json.relationships @relationships do |relationship|
  json.partial! 'relationship', relationship: relationship
end