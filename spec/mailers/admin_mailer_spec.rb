require "spec_helper"

describe AdminMailer do
  let(:user) { build(:user) }
  let(:admin_email) do
    ENV["ADMIN_EMAIL"] || ENV["GMAIL_USERNAME"] || "test@test.com"
  end

  def deliveries
    ActionMailer::Base.deliveries.size
  end

  describe ".confirm_enrollment" do
    let(:course) { build(:course) }
    let(:mail) { AdminMailer.confirm_enrollment(user, course) }

    it "confirms course enrollment" do
      expect(mail.to).to include(admin_email)
      expect(mail.body).to include(user.email)
      expect(mail.body).to include(course.name)
    end

    it "actually sends the email" do
      expect { mail.deliver! }.to change { deliveries }.by(1)
    end
  end

  describe ".send_feedback" do
    let(:page) { "/feedback.html" }
    let(:name) { user.name }
    let(:message) { "This is my feedback message." }
    let(:mail) { AdminMailer.send_feedback(user, name, page, message) }

    context "from real user" do
      it "sends feedback email" do
        expect(mail.to).to include(admin_email)
        expect(mail.from).to include(user.email)
        expect(mail.body).to include(page)
        expect(mail.body).to include(message)
      end

      it "actually sends the email" do
        expect { mail.deliver! }.to change { deliveries }.by(1)
      end
    end

    context "from guest" do
      let(:user) { Guest.new }

      it "sends from a default address" do
        expect(mail.from).to include(user.email)
      end
    end
  end
end
