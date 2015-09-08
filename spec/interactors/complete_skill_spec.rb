require 'spec_helper'

describe CompleteSkill do
  subject { described_class }
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  def interactor(skill = skill, user = user)
    @interactor ||= subject.new(skill: skill, user: user).call
  end

  it "allows the user to complete a skill" do
    expect(interactor).to be_success
    expect(user.skills(skill.category)).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)
    expect(interactor).not_to be_success
  end

  it "tries to complete deadlines too" do
    allow(CompleteDeadline).to receive(:call)

    interactor

    expect(CompleteDeadline).to have_received(:call).with(user: user, category: skill.category)
  end

  context "with organizations" do
    let(:me) { create(:user, organization: "good guys") }
    let(:us) { create(:course, :with_skills, organization: "good guys") }
    let(:our_sekkret) { us.skills.first }

    let(:them) { create(:course, :with_skills, organization: "bad guys") }
    let(:their_sekkret) { them.skills.first }

    let(:rando) { create(:user, organization: nil) }
    let(:not_sekkret) { create(:skill) }

    it "will let me complete proprietary skills" do
      expect(interactor(our_sekkret, me)).to be_success
    end

    it "will let me complete non-secret skills" do
      expect(interactor(not_sekkret, me)).to be_success
    end

    it "won't let me complete sekkret skills from other orgs" do
      expect(interactor(their_sekkret, me)).not_to be_success
    end

    it "won't let me complete sekkret skills without an org" do
      expect(interactor(our_sekkret, rando)).not_to be_success
    end
  end
end
