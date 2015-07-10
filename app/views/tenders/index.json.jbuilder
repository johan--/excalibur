json.array!(@tenders) do |tender|
  json.extract! tender, :id
  json.url tender_url(tender, format: :json)
end
