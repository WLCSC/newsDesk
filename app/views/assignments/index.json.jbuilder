json.array!(@assignments) do |assignment|
  json.extract! assignment, 
  json.url assignment_url(assignment, format: :json)
end
