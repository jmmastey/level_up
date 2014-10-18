Given /^a user exists with some training progress$/ do
  @user = FactoryGirl.create(:user, :enrolled)

  # now finish a few skills
  Skill.all.take(4).map do |skill|
    FactoryGirl.create(:completion, :verified, user: @user,
                       skill: skill, created_at: Date.today)
  end
end

Given /^there are other users with completions$/ do
  @users = []
  2.times { @users << FactoryGirl.create(:user, :skilled) }
  @user = @users.first
end

When /^I visit the users page$/ do
  visit users_path
end

When /^I visit a user's profile page$/ do
  visit user_path(@user)
end

When /^I click a user's profile link$/ do
  click_link @user.name
end

Then /^I see that user's profile$/ do
  expect(page).to have_content(@user.name)
end

Then /^I see their pretty picture$/ do
  expect(page).to have_css("img.gravatar")
end

Then /^I see their skills$/ do
  skills = @user.reload.skills
  skills.each do |skill|
    expect(page).to have_css(".skill.completed.#{skill.handle}")
  end
end

Then /^I see a profile link in the header$/ do
  expect(page).to have_css("header .profile")
end

Then /^I see all the other users with completions$/ do
  @users.each do |user|
    expect(page).to have_css(".user-#{user.id}")
    expect(all(".user-#{user.id}")).to have(1).item
  end
end
