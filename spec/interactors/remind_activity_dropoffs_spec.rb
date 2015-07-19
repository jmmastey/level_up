require 'spec_helper'

describe RemindActivityDropoffs do
  subject(:interactor) { RemindActivityDropoffs }
  let(:mail) { double("UserMailer", deliver_now: true) }
  let(:user) { create(:user, name: "Old User", created_at: 2.weeks.ago) }
  let(:course) { create(:course, :with_skills) }
  let!(:enrollment) do
    create(:enrollment, user: user, course: course, created_at: 2.weeks.ago)
  end

  it "sends email to users who've become stuck" do
    # TODO: the interface of Interactor is really getting in the way
    # of decent form here. consider removing interactor altogether.
    # In particular, this any-instance shit is a lot of indirection,
    # and it's hard to dependency inject the mailers because of the
    # silliness in context.
    expect_any_instance_of(subject).to receive(:targets)
      .and_return([enrollment])
    expect(UserMailer).to receive(:activity_reminder).and_return(mail)
    subject.new.call
  end

  it "finds only enrolled but stuck users" do
    young    = create(:enrollment, course: course, created_at: 1.day.ago)
    complete = create(:enrollment) # no skills, fucker

    expect_any_instance_of(subject).to receive(:remind).with(enrollment)
    expect_any_instance_of(subject).not_to receive(:remind).with(young)
    expect_any_instance_of(subject).not_to receive(:remind).with(complete)

    subject.new.call
  end

  it "sends emails only once" do
    expect_any_instance_of(subject).to receive(:remind).with(enrollment).once

    subject.new.call
    subject.new.call
  end
end
