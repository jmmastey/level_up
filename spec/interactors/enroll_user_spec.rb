require 'spec_helper'

describe EnrollUser do
  let(:course) { create(:course) }
  let(:user) { create(:user) }
  let(:interactor) { EnrollUser.call(course: course, user: user) }

  let(:mail) { double("AdminMailer", deliver_now: deliver) }

  context "when the interactor is a success" do
    let(:deliver) { true }

    it "allows a user to register for a course" do
      expect(interactor).to be_success
      expect(user.courses).to include(course)
    end

    it "sends welcome and notification emails" do
      expect(AdminMailer).to receive(:confirm_enrollment).once
        .with(user, course).and_return(mail)
      expect(UserMailer).to receive(:confirm_enrollment).once
        .with(user, course).and_return(mail)

      expect(interactor).to be_success
    end
  end

  context "when emails cannot be sent" do
    let(:deliver) { false }
    it "fails when emails cannot be sent properly" do
      expect(AdminMailer).to receive(:confirm_enrollment)
        .with(user, course).and_return(mail)

      expect(interactor).not_to be_success
    end
  end

end
