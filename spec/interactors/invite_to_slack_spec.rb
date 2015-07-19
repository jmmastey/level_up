require 'spec_helper'
require 'pry'

describe InviteToSlack do
  subject(:interactor) { described_class }
  let(:mail) { double("UserMailer", deliver_now: true) }
  let!(:user) { User.new }

  it "sends email as requested" do
    expect(UserMailer).to receive(:slack_reminder).with(user).and_return(mail)
    expect_any_instance_of(subject).to receive(:update).and_return(true)

    subject.new(users: [user]).call
  end

  it "updates the user" do
    expect(user).to receive(:update_attributes!)
    subject.new(users: [user]).call
  end

  it "bails if the email has been sent before" do
    allow(user).to receive(:slack_invite_sent_at).and_return(Date.today)

    expect(UserMailer).not_to receive(:slack_reminder)
    subject.new(users: [user]).call
  end

  it "bails if the user doesn't want to receive emails" do
    allow(user).to receive(:email_opt_out).and_return(:bad_email)

    expect(UserMailer).not_to receive(:slack_reminder)
    subject.new(users: [user]).call
  end
end
