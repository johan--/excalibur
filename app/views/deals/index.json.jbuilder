json.array!(@deals) do |deal|
  json.extract! deal, :id
  json.url deal_url(deal, format: :json)
end
