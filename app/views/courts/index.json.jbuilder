json.array!(@courts) do |court|
  json.extract! court, :id, :name, :venue_id, :price, :category, :rating
  json.url court_url(court, format: :json)
end
