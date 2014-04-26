require 'spec_helper'

describe CompleteSkill do
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  it "should allow the user to complete a skill" do
    interactor = CompleteSkill.perform(skill: skill, user: user)
    interactor.should be_success

    user.skills(skill.category).should include(skill)
  end

  it "should not allow completions to exist twice" do
    create(:completion, skill: skill, user: user)

    interactor = CompleteSkill.perform(skill: skill, user: user)
    interactor.should be_failure
  end

end
