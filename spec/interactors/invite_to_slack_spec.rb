require 'spec_helper'
require 'pry'

describe InviteToSlack do
  subject(:interactor) { InviteToSlack.new(users: [user], user_mailer: umail) }
  let(:umail) { spy("UserMailer", slack_reminder: spy) }
  let!(:user) { User.new }

  it "sends email as requested" do
    allow(interactor).to receive(:update) { true }

    interactor.call

    expect(umail).to have_received(:slack_reminder).with(user)
    expect(interactor).to have_received(:update)
  end

  it "updates the user" do
    allow(user).to receive(:update_attributes!) { true }

    interactor.call
    expect(user).to have_received(:update_attributes!)
  end

  it "bails if the email has been sent before" do
    user.slack_invite_sent_at = Date.today

    interactor.call
    expect(umail).not_to have_received(:slack_reminder)
  end

  it "bails if the user doesn't want to receive emails" do
    user.email_opt_out = :bad_email

    interactor.call
    expect(umail).not_to have_received(:slack_reminder)
  end
end
