json.array!(@firms) do |firm|
  json.extract! firm, :id, :name, :region, :city, :address, :phone
  json.url firm_url(firm, format: :json)
end
