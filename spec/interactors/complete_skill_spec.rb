require 'spec_helper'

describe CompleteSkill do
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  it "allows the user to complete a skill" do
    interactor = CompleteSkill.call(skill: skill, user: user)
    expect(interactor).to be_success

    expect(user.skills(skill.category)).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)

    interactor = CompleteSkill.call(skill: skill, user: user)
    expect(interactor).not_to be_success
  end

  context "with organizations" do
    let(:me) { create(:user, organization: "us") }
    let(:us) { create(:course, :with_skills, organization: "us") }
    let(:our_sekkret) { us.skills.first }

    it "will let me complete proprietary skills" do
      interactor = CompleteSkill.call(skill: our_sekkret, user: me)
      expect(interactor).to be_success
    end

    it "will let me complete non-secret skills" do
      not_sekkret = create(:skill)
      interactor  = CompleteSkill.call(skill: not_sekkret, user: me)
      expect(interactor).to be_success
    end

    it "won't let me complete sekkret skills from other orgs" do
      sekkret = create(:course, :with_skills, organization: "them").skills.first
      interactor    = CompleteSkill.call(skill: sekkret, user: me)
      expect(interactor).not_to be_success
    end

    it "won't let me complete sekkret skills without an org" do
      him         = create(:user, organization: nil)
      interactor  = CompleteSkill.call(skill: our_sekkret, user: him)
      expect(interactor).not_to be_success
    end
  end
end
