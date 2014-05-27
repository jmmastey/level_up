require 'spec_helper'

describe UncompleteSkill do
  let!(:completion) { create(:completion, skill: skill, user: user) }
  let(:user)        { create(:user) }
  let(:skill)       { create(:skill) }

  it "should allow the user to uncomplete a skill" do
    interactor = UncompleteSkill.perform(skill: skill, user: user)
    interactor.should be_success

    user.skills.should_not include(skill)
  end

  it "should not allow uncompletion for an incomplete skill" do
    completion = create(:completion)
    skill = create(:skill)

    interactor = UncompleteSkill.perform(skill: skill, user: user)
    interactor.should be_failure
  end

end
