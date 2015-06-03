json.array!(@installments) do |installment|
  json.extract! installment, :id
  json.url installment_url(installment, format: :json)
end
