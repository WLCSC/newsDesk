json.array!(@feeds) do |feed|
  json.extract! feed, :name, :url, :organization_id
  json.url feed_url(feed, format: :json)
end
