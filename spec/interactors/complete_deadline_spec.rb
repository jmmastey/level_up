require 'spec_helper'

describe CompleteDeadline do
  subject(:interactor) { described_class }
  let(:user)  { create(:user) }
  let(:skill) { create(:skill) }
  let(:category) { skill.category }

  def interactor_for(category, user)
    subject.new(category: category, user: user).call
  end

  it "does nothing if there is no deadline" do
    cat = create(:category)

    expect(interactor_for(cat, user)).to be_success
  end

  it "doesn't try to complete if there are uncompleted skills" do
    # create(:completion, skill: skill, user: user) NOPE
    deadline = Deadline.create(category: category, user: user)

    expect(interactor_for(category, user)).to be_success
    expect(deadline.reload.completed_on).to be_nil
  end

  it "toggles deadline completion" do
    create(:completion, skill: skill, user: user)
    deadline = Deadline.create(category: category, user: user)

    expect(interactor_for(category, user)).to be_success
    expect(deadline.reload.completed_on).not_to be_nil
  end
end
