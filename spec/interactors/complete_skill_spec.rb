require 'spec_helper'

describe CompleteSkill do
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  it "allows the user to complete a skill" do
    interactor = CompleteSkill.new(skill: skill, user: user).call
    expect(interactor).to be_success

    expect(user.skills(skill.category)).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)

    interactor = CompleteSkill.new(skill: skill, user: user).call
    expect(interactor).not_to be_success
  end

  context "with organizations" do
    let(:me) { create(:user, organization: "us") }
    let(:us) { create(:course, :with_skills, organization: "us") }
    let(:our_sekkret) { us.skills.first }

    it "will let me complete proprietary skills" do
      interactor = CompleteSkill.new(skill: our_sekkret, user: me).call
      expect(interactor).to be_success
    end

    it "will let me complete non-secret skills" do
      not_sekkret = create(:skill)
      interactor  = CompleteSkill.new(skill: not_sekkret, user: me).call
      expect(interactor).to be_success
    end

    it "won't let me complete sekkret skills from other orgs" do
      sekkret = create(:course, :with_skills, organization: "them").skills.first
      interactor    = CompleteSkill.new(skill: sekkret, user: me).call
      expect(interactor).not_to be_success
    end

    it "won't let me complete sekkret skills without an org" do
      him         = create(:user, organization: nil)
      interactor  = CompleteSkill.new(skill: our_sekkret, user: him).call
      expect(interactor).not_to be_success
    end
  end
end
