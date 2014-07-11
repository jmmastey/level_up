def current_user
  User.find_by_email(@visitor[:email])
end

def create_course(status, name)
  FactoryGirl.create(:course, status: status, name: name)
end

Given(/^there is an? (.*) course called "(.*)"$/) do |status, name|
  create_course(status, name)
end

Given(/^I am enrolled in "(.*)"$/) do |name|
  course = Course.find_by!(name: name)
  Enrollment.create!(user: current_user, course: course)
end

When(/^I visit the courses page$/) do
  visit courses_path
end

When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I see the (.*) course called "(.*)"$/) do |status, name|
  course = create_course(status, name)
  expect(page).to have_content(course.name)
end
