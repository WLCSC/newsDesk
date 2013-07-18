json.array!(@organizations) do |organization|
  json.extract! organization, :name, :description
  json.url organization_url(organization, format: :json)
end
