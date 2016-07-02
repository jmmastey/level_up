require "spec_helper"

describe UserMailer do
  let(:enrollment) { build(:enrollment) }
  let(:user) { enrollment.user }
  let(:course) { enrollment.course }
  let(:helpful_url) { "mailto:jmmastey@gmail.com" }

  describe "#confirm_enrollment" do
    let(:mail) { UserMailer.confirm_enrollment(user, course) }

    it "confirms course enrollment" do
      expect(mail.to).to include(user.email)
      expect(mail.body).to include(course.name)
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#activity_reminder" do
    let(:mail) { UserMailer.activity_reminder(enrollment) }

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#reg_reminder" do
    let(:mail) { UserMailer.reg_reminder(user) }

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#deadline_reminder" do
    let(:deadline) { FactoryGirl.create(:deadline) }
    let(:mail) { UserMailer.deadline_reminder(deadline) }

    it "tells you about your deadline" do
      expect(mail.body).to include(deadline.category.name)
      expect(mail.body).to include(deadline.target_completed_on)
      expect(mail.body).to include("/#{deadline.category.handle}.html")
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  def deliveries
    ActionMailer::Base.deliveries.size
  end
end
