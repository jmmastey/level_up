require 'spec_helper'

describe SendFeedback do
  subject(:interactor) { described_class.new(params) }
  let(:user) { create(:user) }
  let(:page) { "page" }
  let(:message) { "message" }
  let(:params) { { user: user, page: page, message: message } }

  context "when the interactor is a success" do
    let(:mail) { double("AdminMailer", deliver_now!: true) }

    it "sends feedback emails" do
      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, page, message).and_return(mail)

      expect(subject.call).to be_success
    end
  end

  context "when emails cannot be sent" do
    let(:mail) { double("AdminMailer") }

    it "fails when emails cannot be sent properly" do
      expect(mail).to receive(:deliver_now!).once.and_raise

      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, page, message).and_return(mail)

      expect(subject.call).not_to be_success
    end
  end
end
