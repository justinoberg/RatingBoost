json.array!(@reviews) do |review|
  json.extract! review, :id, :rating, :comment, :name, :email
  json.url review_url(review, format: :json)
end
