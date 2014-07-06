Given /^a user exists with some training progress$/ do
  @user = FactoryGirl.create(:user, :enrolled)

  # now finish a few skills
  Skill.all.take(4).map do |skill|
    FactoryGirl.create(:completion, :verified, user: @user, skill: skill, created_at: Date.today)
  end
end

When /^I visit a user's profile page/ do
  visit user_path(@user)
end

Then /^I see that user's profile/ do
  expect(page).to have_content(@user.name)
end

Then /^I see their pretty picture/ do
  expect(page).to have_css("img.gravatar")
end

Then /^I see their skills/ do
  skills = @user.reload.skills
  skills.each do |skill|
    expect(page).to have_css(".skill.completed.#{skill.handle}")
  end
end

Then /^I see a profile link in the header/ do
  expect(page).to have_css("header .profile")
end
