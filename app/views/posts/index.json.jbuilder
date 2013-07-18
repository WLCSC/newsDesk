json.array!(@posts) do |post|
  json.extract! post, :title, :data, :user_id, :approved, :start, :end, :organization_id
  json.url post_url(post, format: :json)
end
