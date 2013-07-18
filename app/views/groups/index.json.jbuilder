json.array!(@groups) do |group|
  json.extract! group, :name, :auth_attribute, :auth_value
  json.url group_url(group, format: :json)
end
