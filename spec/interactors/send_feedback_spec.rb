require 'spec_helper'

describe SendFeedback do
  subject(:interactor) do
    described_class.new(user: user, page: "pg",
                        message: "msg", admin_mailer: amailer)
  end

  let(:amailer) { class_double(AdminMailer, send_feedback: spy) }
  let(:user)    { create(:user) }

  context "when the interactor is a success" do
    it "sends feedback emails" do
      expect(interactor.call).to be_success
      expect(amailer).to have_received(:send_feedback).with(user, "pg", "msg")
    end
  end

  context "when emails cannot be sent" do
    it "fails when emails cannot be sent properly" do
      allow(amailer).to receive(:send_feedback).and_raise
      expect(subject.call).not_to be_success
    end
  end
end
