require 'spec_helper'

describe EnrollUser do
  let(:course) { create(:course) }
  let(:user) { create(:user) }
  let(:interactor) { EnrollUser.perform(course: course, user: user) }

  let(:mail) { double("AdminMailer", deliver: deliver) }

  context "when the interactor is a success" do
    let(:deliver) { true }

    it "should allow a user to register for a course" do
      EnrollUser.any_instance.should_receive(:send_welcome_email).and_return(true)

      interactor.should be_success
      user.courses.should include(course)
    end

    it "should send welcome and notification emails" do
      AdminMailer.should_receive(:confirm_enrollment).once.with(user, course).and_return(mail)
      UserMailer.should_receive(:confirm_enrollment).once.with(user, course).and_return(mail)

      interactor.should be_success
    end
  end

  context "when emails cannot be sent" do
    let(:deliver) { false }
    it "should fail when emails cannot be sent properly" do
      AdminMailer.should_receive(:confirm_enrollment).with(user, course).and_return(mail)

      interactor.should_not be_success
    end
  end

end
