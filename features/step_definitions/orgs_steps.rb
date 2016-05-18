# Given

def create_org_user(name, organization = nil)
  FactoryGirl.create(:user, :skilled, name: name, organization: organization)
end

Given(/^there are users from many orgs$/) do
  @no_org_user    = create_org_user("Rob Rando")
  @other_rando    = create_org_user("Steve Stranger")
  @my_org_user    = create_org_user("Me I Myself", "my_org")
  @colleague      = create_org_user("Coworker Bill", "my_org")
  @other_org_user = create_org_user("Competitor Chris", "other_org")
end

def create_org_course(name, handle, org = nil)
  FactoryGirl.create(:course, :published, name: name,
                     handle: handle, organization: org)
end

Given(/^there are courses from many orgs$/) do
  @no_org_course    = create_org_course("General Studies", "rails")
  @my_org_course    = create_org_course("Our Secrets", "linux", "my_org")
  @other_org_course = create_org_course("Their Secrets", "ruby", "other_org")
end

Given(/^I am some rando from the internet$/) do
  do_user_sign_in(email: @no_org_user.email, password: @no_org_user.password)
end

Given(/^I am a user from an organization$/) do
  do_user_sign_in(email: @my_org_user.email, password: @my_org_user.password)
end

# Then

Then(/^I don't see the courses from any orgs$/) do
  expect(page).not_to have_content(@my_org_course.name)
  expect(page).not_to have_content(@other_org_course.name)
end

Then(/^I see courses without any org$/) do
  expect(page).to have_content(@no_org_course.name)
end

Then(/^I see the courses from my org$/) do
  expect(page).to have_content(@my_org_course.name)
end

Then(/^I don't see the courses from other orgs$/) do
  expect(page).not_to have_content(@other_org_course.name)
end

Then(/^I see other randos from the internet$/) do
  expect(page).to have_content(@other_rando.name)
end

Then(/^I don't see users from any orgs$/) do
  expect(page).not_to have_content(@my_org_user.name)
  expect(page).not_to have_content(@other_org_user.name)
  expect(page).not_to have_content(@colleague.name)
end

Then(/^I see other users from my org$/) do
  expect(page).to have_content(@colleague.name)
end

Then(/^I don't see users from other orgs$/) do
  expect(page).not_to have_content(@other_org_user.name)
end

Then(/^I don't see randos from the internet$/) do
  expect(page).not_to have_content(@other_rando.name)
end
