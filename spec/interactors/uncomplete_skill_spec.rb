require 'spec_helper'

describe UncompleteSkill do
  subject(:interactor) { described_class }
  let(:user)      { create(:user) }
  let(:bow_staff) { create(:skill) }

  def interactor_for(skill, user)
    subject.new(skill: skill, user: user).call
  end

  it "allows the user to uncomplete a skill" do
    create(:completion, skill: bow_staff, user: user)

    expect(interactor_for(bow_staff, user)).to be_success
    expect(user.skills).not_to include(bow_staff)
  end

  it "doesn't allow uncompletion for an incomplete skill" do
    expect(interactor_for(bow_staff, user)).not_to be_success
  end
end
