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
  Course.find_by_name(name).enroll!(current_user)
end

When(/^I visit the courses page$/) do
  visit "/courses"
end

Then(/^I should see the (.*) course called "(.*)"$/) do |status, name|
  course = create_course(status, name)
  page.should have_content(course.name)
end
