# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file .env file.
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

CATEGORIES = [
  [ "Linux", "linux" ],
  [ "Ruby I", "ruby_1" ],
  [ "Ruby II", "ruby_2" ],
  [ "Rails I", "rails_1" ],
  [ "Rails II", "rails_2" ],
  [ "Test I", "test_1" ],
  [ "Test II", "test_2" ],
  [ "Data I", "data_1" ],
  [ "Data II", "data_2" ],
  [ "Interaction I", "interaction_1" ],
  [ "Interaction II", "interaction_2" ],
  [ "Engineering I", "engineering_1" ],
  [ "Engineering II", "engineering_2" ],
  [ "Business", "business" ],
  [ "Professionalism", "professionalism" ],
  [ "Cnuapp", "cnuapp" ],
  [ "8 Boxes", "8boxes" ],
]

CATEGORIES.each do |cat|
  Category.create name: cat[0], handle: cat[1]
  puts "category: #{cat[0]}"
end

SKILLS = [
  [ "Understands that everything is a file", "everything_is_a_file", "linux" ],
]
SKILLS.each do |skill|
  cat = Category.find_by_handle skill[2]
  Skill.create name: skill[0], handle: skill[1], category: cat
  puts "skill: #{skill[0]}"
end
