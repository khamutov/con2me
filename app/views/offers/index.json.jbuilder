json.array!(@offers) do |offer|
  json.extract! offer, :id, :category_id, :price, :desc, :name, :phone
  json.url offer_url(offer, format: :json)
end
