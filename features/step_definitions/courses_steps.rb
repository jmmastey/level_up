def current_user
  User.find_by_email(@visitor[:email])
end

def create_course(status, name)
  FactoryGirl.create(:course, :with_related_category, status: status,
                     name: name, handle: name.gsub(' ', '_').underscore)
end

def create_enrollment(course)
  Enrollment.create!(user: current_user, course: course)
end

Given(/^there is an? (.*) course called "(.*)"$/) do |status, name|
  create_course(status, name)
end

Given(/^I am enrolled in "(.*)"$/) do |name|
  course = Course.find_by!(name: name)
  create_enrollment(course)
end

Given(/I am enrolled in a course called "(.*)"/) do |name|
  course = create_course("published", name)
  create_enrollment(course)
end

When(/^I visit the courses page$/) do
  visit courses_path
end

When(/^I visit the homepage$/) do
  visit root_path
end

When(/^I click on the "(.*)" enroll button$/) do |handle|
  find(".course.#{handle} .register .btn").click
end

Then(/^I see the (.*) course called "(.*)"$/) do |status, name|
  course = Course.find_by!(name: name, status: status)
  expect(page).to have_content(course.name)
end

Then(/^I have been enrolled in "(.*)"$/) do |handle|
  @course = Course.find_by!(handle: handle)
  expect(Enrollment.where(course: @course, user: current_user)).not_to be_empty
end

Then(/^I see the "(.*)" course page$/) do |handle|
  @course = Course.find_by!(handle: handle)
  expect(page).to have_content(@course.name)
end
