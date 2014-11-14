json.extract! @user, :id, :name, :created_at, :updated_at
json.image_url gravatar_image_url(@user.email)
json.courses @user.courses do |course|
  json.extract! course, :name
  json.url course_url(course)
end
json.recent_actions feed_items_for(@user) do |item|
  json.label item[:label]
  json.created_at item[:item].created_at
  json.tags item[:tags]
end
