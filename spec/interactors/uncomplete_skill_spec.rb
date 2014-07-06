require 'spec_helper'

describe UncompleteSkill do
  let!(:completion) { create(:completion, skill: skill, user: user) }
  let(:user)        { create(:user) }
  let(:skill)       { create(:skill) }

  it "allows the user to uncomplete a skill" do
    interactor = UncompleteSkill.perform(skill: skill, user: user)

    expect(interactor).to be_success
    expect(user.skills).not_to include(skill)
  end

  it "doesn't allow uncompletion for an incomplete skill" do
    completion = create(:completion)
    skill = create(:skill)

    interactor = UncompleteSkill.perform(skill: skill, user: user)
    expect(interactor).to be_failure
  end

end
