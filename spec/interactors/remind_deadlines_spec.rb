require 'spec_helper'

describe RemindDeadlines do
  subject(:interactor) { described_class.new(user_mailer: umailer, now: now) }
  let(:now) { Time.now }
  let(:umailer) { spy("UserMailer") }
  let(:deadline) { Deadline.new(user: User.new) }

  it "sends email to users who've become stuck" do
    allow(deadline).to receive(:update_attributes!) { true }
    allow(interactor).to receive(:targets) { [deadline] }

    interactor.call

    expect(umailer).to have_received(:deadline_reminder).with(deadline)
  end

  it "finds only users who have set (and nearly missed) deadlines" do
    allow(Deadline).to receive(:nearly_expired) { Deadline.none }

    interactor.call

    expect(Deadline).to have_received(:nearly_expired)
  end

  it "updates the deadline params" do
    allow(interactor).to receive(:targets) { [deadline] }
    allow(deadline).to receive(:update_attributes!) { true }

    interactor.call

    expect(deadline).to have_received(:update_attributes!).with(reminder_sent_at: now)
  end

  it "doesn't send email if you opted out" do
    deadline.user.email_opt_out = "potato"
    allow(interactor).to receive(:targets) { [deadline] }

    interactor.call

    expect(umailer).not_to have_received(:deadline_reminder)
  end
end
