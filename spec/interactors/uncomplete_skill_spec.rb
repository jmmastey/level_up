require 'spec_helper'

describe UncompleteSkill do
  let!(:completion) { create(:completion, skill: crochet, user: user) }
  let(:user)        { create(:user) }
  let(:crochet)       { create(:skill) }

  it "allows the user to uncomplete a skill" do
    interactor = UncompleteSkill.new(skill: crochet, user: user).call

    expect(interactor).to be_success
    expect(user.skills).not_to include(crochet)
  end

  it "doesn't allow uncompletion for an incomplete skill" do
    bow_staff = create(:skill)

    interactor = UncompleteSkill.new(skill: bow_staff, user: user).call
    expect(interactor).not_to be_success
  end
end
