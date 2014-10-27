require 'spec_helper'

describe SendFeedback do
  let(:user) { create(:user) }
  let(:name) { user.name }
  let(:page) { "page" }
  let(:message) { "message" }
  let(:params) { { user: user, name: name, page: page, message: message } }

  let(:interactor) { SendFeedback.call(params) }
  let(:mail) { double("AdminMailer", deliver: deliver) }

  context "when the interactor is a success" do
    let(:deliver) { true }

    it "sends feedback emails" do
      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, name, page, message).and_return(mail)

      expect(interactor).to be_success
    end
  end

  context "when emails cannot be sent" do
    let(:deliver) { false }

    it "fails when emails cannot be sent properly" do
      expect(AdminMailer).to receive(:send_feedback).once
        .with(user, name, page, message).and_return(mail)

      expect(interactor).not_to be_success
    end
  end

end
