require 'spec_helper'

describe InviteToSlack do
  subject(:interactor) { described_class }
  let(:mail) { double("UserMailer", deliver_now: true) }
  let!(:user) { double("User", slack_invite_sent_at: nil) }

  it "sends email as requested" do
    user = double("User", slack_invite_sent_at: nil, email_opt_out: nil)
    expect(UserMailer).to receive(:slack_reminder).with(user).and_return(mail)
    expect_any_instance_of(subject).to receive(:update).and_return(true)

    subject.call(users: [user])
  end

  it "updates the user" do
    user = double("User", slack_invite_sent_at: nil, email_opt_out: nil)

    expect(user).to receive(:update_attributes!)
    subject.call(users: [user])
  end

  it "bails if the email has been sent before" do
    user = double("User", slack_invite_sent_at: Date.today, email_opt_out: nil)

    expect(UserMailer).not_to receive(:slack_reminder)
    subject.call(users: [user])
  end

  it "bails if the user doesn't want to receive emails" do
    user = double("User", slack_invite_sent_at: nil, email_opt_out: :bad_email)

    expect(UserMailer).not_to receive(:slack_reminder)
    subject.call(users: [user])
  end
end
