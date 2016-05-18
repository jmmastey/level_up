### UTILITY METHODS ###

def create_visitor
  @visitor ||= { name: "Testy McUserton", email: "example@example.com",
                 password: "changeme", password_confirmation: "changeme" }
end

def find_user
  @user ||= User.find_by email: @visitor[:email]
end

def create_unconfirmed_user
  create_visitor
  delete_user
  do_user_sign_up
  visit '/users/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  @user ||= User.find_by email: @visitor[:email]
  @user.destroy unless @user.nil?
end

def do_user_sign_up
  delete_user
  fill_sign_up_form
  find_user
end

def fill_sign_up_form
  visit '/users/sign_up'
  fill_in "Name", with: @visitor[:name]
  fill_in "Email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
end

def do_user_sign_in(user = @visitor)
  visit '/users/sign_in'
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  click_button "Sign in"
end

def expect_flash_message(message)
  msg_location = page.html =~ /site_alerts.push\("#{message}/
  expect(msg_location).not_to be_nil, "Couldn't find message: #{message}"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  do_user_sign_in
end

Given /^I am logged in and wait$/ do
  create_user
  do_user_sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  do_user_sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  do_user_sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(email: "notanemail")
  do_user_sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "")
  do_user_sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(password: "")
  do_user_sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "changeme123")
  do_user_sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(email: "wrong@example.com")
  do_user_sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(password: "wrongpass")
  do_user_sign_in
end

When /^I edit my account details$/ do
  visit user_path(@user)
  click_link "edit-profile"
  fill_in "Name", with: "newname"
  fill_in "user_current_password", with: @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I am signed in$/ do
  expect(page).to have_content "Logout"
  expect(page).not_to have_content "Sign Up"
  expect(page).not_to have_content "Login"
end

Then /^I am signed out$/ do
  expect(page).to have_content "Sign Up"
  expect(page).to have_content "Sign In"
  expect(page).not_to have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  expect_flash_message "You have to confirm your account"
end

Then /^I see a successful sign in message$/ do
  expect_flash_message "Signed in successfully."
end

Then /^I see a successful sign up message$/ do
  expect_flash_message "Welcome! You have signed up successfully."
end

Then /^I see an invalid email message$/ do
  expect(page).to have_content "Email is invalid"
end

Then /^I see a missing password message$/ do
  expect(page).to have_content "Password can't be blank"
end

Then /^I see a missing password confirmation message$/ do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Then /^I see a mismatched password message$/ do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Then /^I see a signed out message$/ do
  expect_flash_message "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  expect_flash_message "Invalid email or password."
end

Then /^I see an account edited message$/ do
  expect_flash_message "You updated your account successfully."
end

Then /^I see my name$/ do
  create_user
  expect(page).to have_content @user[:name]
end
