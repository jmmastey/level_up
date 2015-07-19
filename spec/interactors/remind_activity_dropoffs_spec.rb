require 'spec_helper'

describe RemindActivityDropoffs do
  subject(:interactor) { described_class.new }
  let(:mail) { double("UserMailer", deliver_now: true) }
  let(:user) { create(:user, name: "Old User", created_at: 2.weeks.ago) }
  let(:course) { create(:course, :with_skills) }
  let!(:enrollment) do
    create(:enrollment, user: user, course: course, created_at: 2.weeks.ago)
  end

  it "sends email to users who've become stuck" do
    expect(subject).to receive(:targets).and_return([enrollment])
    expect(UserMailer).to receive(:activity_reminder).and_return(mail)
    subject.call
  end

  it "finds only enrolled but stuck users" do
    young    = create(:enrollment, course: course, created_at: 1.day.ago)
    complete = create(:enrollment) # no skills, fucker

    expect(subject).to receive(:remind).with(enrollment)
    expect(subject).not_to receive(:remind).with(young)
    expect(subject).not_to receive(:remind).with(complete)

    subject.call
  end

  it "sends emails only once" do
    expect(subject).to receive(:remind).with(enrollment).once

    subject.call
    subject.call
  end
end
