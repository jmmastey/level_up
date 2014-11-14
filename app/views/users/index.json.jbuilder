json.array!(@users) do |user|
  json.extract! user, :id, :name
  json.url user_url(user, format: :json)
  json.image_url gravatar_image_url(user.email)

  json.courses user.courses do |course|
    json.extract! course, :name
    json.url course_url(course)
  end
end
