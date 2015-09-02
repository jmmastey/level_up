require 'spec_helper'

describe RemindRegistrationDropoffs do
  subject(:interactor) { described_class.new(user_mailer: umailer) }
  let(:umailer) { double("UserMailer", reg_reminder: spy) }

  it "sends email to users who haven't registered" do
    allow(interactor).to receive(:lazy_users) { [create(:user)] }

    interactor.call

    expect(umailer).to have_received(:reg_reminder)
  end

  it "finds old users with no enrollments" do
    enrolled_user = create(:enrollment).user
    new_user      = create(:user, name: "New User")
    old_user      = create(:user, name: "Old User", created_at: 3.weeks.ago)
    allow(interactor).to receive(:remind)

    interactor.call

    expect(interactor).to have_received(:remind).with(old_user)
    expect(interactor).not_to have_received(:remind).with(new_user)
    expect(interactor).not_to have_received(:remind).with(enrolled_user)
  end

  it "sends emails only once" do
    user = create(:user, created_at: 3.weeks.ago)
    allow(interactor).to receive(:remind)

    interactor.call.call

    expect(interactor).to have_received(:remind).with(user).once
  end

  it "doesn't send emails for users who don't want to receive them" do
    optout = create(:user, created_at: 3.weeks.ago, email_opt_out: :bad_email)
    allow(interactor).to receive(:remind)

    interactor.call

    expect(interactor).not_to have_received(:remind).with(optout)
  end
end
