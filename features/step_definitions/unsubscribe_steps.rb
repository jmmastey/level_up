def unsub_link
  @user ||= create_user
  @link ||= UnsubscribeLink.for_user(@user)
end

When(/^I visit the unsubscribe page$/) do
  visit unsubscribe_path
end

When(/^I click on unsubscribe$/) do
  find("#unsubscribe").click
end

When(/^I visit unsubscribe with a token$/) do
  visit "/unsubscribe/#{unsub_link.token}"
end

Then(/^I am on the unsubscribe confirmation page$/) do
  expect(page.current_url).to match(/unsubscribe$/)
  expect(page).to have_css(".unsubscription_confirmation")
end

Then(/^I see a message that I am unsubscribed$/) do
  expect(page).to have_css(".unsubscription_happened")
end

Then(/^I am unsubscribed$/) do
  expect(@user.reload.email_opt_out).to eq("unsubscribed")
end

Then(/^I see a link to unsubscribe from emails$/) do
  expect(page).to have_css("#unsubscribe")
end
