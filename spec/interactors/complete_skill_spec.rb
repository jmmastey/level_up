require 'spec_helper'

describe CompleteSkill do
  subject { described_class }
  let(:category)  { create(:category) }
  let(:skill)     { create(:skill, category: category) }
  let(:user)      { create(:user) }

  def interactor(the_skill: skill, the_user: user)
    subject.new(skill: the_skill, user: the_user).call
  end

  it "requires a valid skill" do
    response = interactor(the_skill: nil)
    expect(response.errors).to include("provide a valid skill")
  end

  it "allows the user to complete a skill" do
    expect(interactor).to be_success
    expect(user.skills.reload).to include(skill)
  end

  it "doesn't allow completions to exist twice" do
    create(:completion, skill: skill, user: user)
    expect(interactor).not_to be_success
  end

  it "tries to complete deadlines too" do
    allow(CompleteDeadline).to receive(:call)

    interactor

    expect(CompleteDeadline).to have_received(:call)
      .with(user: user, category: skill.category)
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
      expect(interactor(the_skill: our_sekkret, the_user: me)).to be_success
    end

    it "will let me complete non-secret skills" do
      expect(interactor(the_skill: not_sekkret, the_user: me)).to be_success
    end

    it "won't let me complete sekkret skills from other orgs" do
      expect(interactor(the_skill: their_sekkret, the_user: me)).not_to be_success
    end

    it "won't let me complete sekkret skills without an org" do
      expect(interactor(the_skill: our_sekkret, the_user: rando)).not_to be_success
    end
  end
end
