require "spec_helper"

describe UserMailer do
  let(:user) { build(:user) }

  describe "#confirm_enrollment" do
    let(:course) { create(:course) }
    let(:mail) { UserMailer.confirm_enrollment(user, course) }

    it "confirms course enrollment" do
      expect(mail.to).to include(user.email)
      expect(mail.body).to include(course.name)
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#slack_reminder" do
    let(:mail) { UserMailer.slack_reminder(user) }

    it "includes the slack invite link" do
      expect(mail.to).to include(user.email)
      expect(mail.body).to include("https://levelupslackinvites.herokuapp.com/")
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  def deliveries
    ActionMailer::Base.deliveries.size
  end
end
