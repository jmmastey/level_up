require 'spec_helper'

describe EnrollUser do
  subject { described_class }
  let(:course)  { create(:course) }
  let(:user)    { create(:user) }

  let(:amailer) { spy("AdminMailer", confirm_enrollment: mail) }
  let(:umailer) { spy("UserMailer", confirm_enrollment: mail) }

  def interactor(opts = {})
    @interactor ||= subject.new({ course: course, user: user }.merge(opts))
  end

  context "when the interactor is a success" do
    let(:mail) { double("mail", deliver_now: true) }

    it "allows a user to register for a course" do
      expect(interactor.call).to be_success
      expect(user.courses).to include(course)
    end

    it "sends welcome and notification emails" do
      interactor = interactor(admin_mailer: amailer, user_mailer: umailer)

      expect(interactor.call).to be_success
      expect(amailer).to have_received(:confirm_enrollment).with(user, course)
      expect(umailer).to have_received(:confirm_enrollment).with(user, course)
    end
  end

  context "when emails cannot be sent" do
    let(:mail) { double("mail", deliver_now: false) }

    it "fails when emails cannot be sent properly" do
      interactor = interactor(admin_mailer: amailer)
      expect(interactor.call).not_to be_success
    end
  end

  context "for organizational courses" do
    it "doesn't allow the user to register if they are of the wrong org" do
      course.update_attributes!(organization: "S.H.I.E.L.D")
      expect(interactor.call).not_to be_success
    end

    it "does allow the user to register if they are of the right org" do
      course.update_attributes!(organization: "S.H.I.E.L.D")
      user.update_attributes!(organization: "S.H.I.E.L.D")

      expect(interactor.call).to be_success
    end
  end
end
