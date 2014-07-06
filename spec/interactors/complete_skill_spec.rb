require 'spec_helper'

describe CompleteSkill do
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  it "allows the user to complete a skill" do
    interactor = CompleteSkill.perform(skill: skill, user: user)
    expect(interactor).to be_success

    expect(user.skills(skill.category)).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)

    interactor = CompleteSkill.perform(skill: skill, user: user)
    expect(interactor).to be_failure
  end

end
