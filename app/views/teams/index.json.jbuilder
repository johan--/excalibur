json.array!(@teams) do |team|
  json.extract! team, :id, :type, :name, :starter_email
  json.url team_url(team, format: :json)
end
