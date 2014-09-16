def category
  @category ||= Category.find_by!(handle: "faux")
end

def skill
  @skill ||= category.skills.last
end

Given(/^I completed a skill$/) do
  FactoryGirl.create(:completion, user: current_user, skill: skill)
end

Given(/^I visit a course page$/) do
  visit "/#{category.handle}.html"
end

When(/^I click on a completion checkbox$/) do
  find("##{skill.handle} .completion .btn").click
end

Then(/^I should have completed that skill$/) do
  expect(Completion.where(skill: skill, user: current_user)).not_to be_empty
end

Then(/^I should not have completed that skill$/) do
  expect(Completion.where(skill: skill, user: current_user)).to be_empty
end
