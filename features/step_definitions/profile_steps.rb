Given /^a user exists with some training progress$/ do
  @user = FactoryGirl.create(:user, :enrolled)
  skills = @user.courses.map(&:skills).flatten

  # now finish a few skills
  skills.take(4).map do |skill|
    FactoryGirl.create(:completion, :verified, user: @user, skill: skill)
  end
end

When /^I visit a user's profile page/ do
  visit user_path(@user)
end

Then /^I should see that user's profile/ do
  page.should have_content(@user.name)
end

Then /^I should see their pretty picture/ do

end

Then /^I should see their skills/ do
  skills = @user.reload.skills
  skills.each do |skill|
    page.should have_css(".skill.completed.#{skill.handle}")
  end
end

