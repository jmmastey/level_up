require 'spec_helper'

describe CompleteSkill do
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  def interactor_for(skill, user)
    CompleteSkill.new(skill: skill, user: user).call
  end

  it "allows the user to complete a skill" do
    expect(interactor_for(skill, user)).to be_success
    expect(user.skills(skill.category)).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)
    expect(interactor_for(skill, user)).not_to be_success
  end

  context "with organizations" do
    let(:me) { create(:user, organization: "us") }
    let(:us) { create(:course, :with_skills, organization: "us") }
    let(:our_sekkret) { us.skills.first }

    it "will let me complete proprietary skills" do
      expect(interactor_for(our_sekkret, me)).to be_success
    end

    it "will let me complete non-secret skills" do
      not_sekkret = create(:skill)
      expect(interactor_for(not_sekkret, me)).to be_success
    end

    it "won't let me complete sekkret skills from other orgs" do
      sekkret = create(:course, :with_skills, organization: "them").skills.first
      expect(interactor_for(sekkret, me)).not_to be_success
    end

    it "won't let me complete sekkret skills without an org" do
      him = create(:user, organization: nil)
      expect(interactor_for(our_sekkret, him)).not_to be_success
    end
  end
end
