require 'spec_helper'

describe RemindRegistrationDropoffs do
  subject(:interactor) { RemindRegistrationDropoffs }
  let(:mail) { double("UserMailer", deliver_now: true) }

  let!(:user) { create(:user, name: "Old User", created_at: 3.weeks.ago) }
  let!(:new_user) { create(:user, name: "New User") }
  let(:enrollment) { create(:enrollment) }
  let!(:enrolled_user) { enrollment.user.tap { |u| u.name = "Enrolled User" } }

  it "sends email to users who haven't registered" do
    expect_any_instance_of(subject).to receive(:lazy_users).and_return([user])
    expect(UserMailer).to receive(:reg_reminder).with(user).and_return(mail)

    subject.new.call
  end

  it "finds old users with no enrollments" do
    expect_any_instance_of(subject).to receive(:remind).with(user)
    expect_any_instance_of(subject).not_to receive(:remind).with(new_user)
    expect_any_instance_of(subject).not_to receive(:remind).with(enrolled_user)

    subject.new.call
  end

  it "sends emails only once" do
    expect_any_instance_of(subject).to receive(:remind).with(user).once

    subject.new.call
    subject.new.call
  end

  it "doesn't send emails for users who don't want to receive them" do
    optout = create(:user, created_at: 3.weeks.ago, email_opt_out: :bad_email)
    expect_any_instance_of(subject).not_to receive(:remind).with(optout)

    subject.new.call
  end
end
