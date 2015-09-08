def enable_deadlines
  @user.update_attributes!(deadline_mode: "on")
end

Given(/^I have deadlines enabled$/) do
  enable_deadlines
end

Given(/^I have deadlines disabled$/) do
  @user.update_attributes!(deadline_mode: nil)
end

Given(/^I have not set any deadlines$/) do
  Deadline.where(user: @user).destroy_all
end

Given(/^I have set a deadline$/) do
  enable_deadlines
  Deadline.create(category: category, user: @user)
end

When(/^I update my deadline preferences$/) do
  select 'Deadline Mode Enabled'
  click_on 'Update'
end

When(/^I choose and submit a deadline$/) do
  fill_in "deadline_target_completed_on", with: "2099-01-01"
  click_on 'Set Deadline'
end

When(/^I click to undo my deadline$/) do
  find(".show-deadline a").click
end

Then(/^my deadline preferences are updated$/) do
  expect(@user.reload.deadline_mode).to eq("on")
end

Then(/^I see my profile updated$/) do
  expect(find("#deadline_mode").value).to eq("on")
end

Then(/^I see the option to set a deadline$/) do
  expect(page).to have_css(".set-deadline")
end

Then(/^I don't see any deadline options$/) do
  expect(page).not_to have_css(".set-deadline")
end

Then(/^I see my deadline reflected$/) do
  expect(page).to have_css(".show-deadline")
  expect(page).to have_content("2099-01-01")
end

Then(/^I see a link to remove my deadline$/) do
  expect(page).to have_css(".show-deadline a")
end
