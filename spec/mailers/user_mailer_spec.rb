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

    it "includes some helpful links" do
      expect(mail.body).to include(helpful_url)
    end
  end

  describe "#activity_reminder" do
    let(:mail) { UserMailer.activity_reminder(enrollment) }

    it "includes some helpful links" do
      expect(mail.body).to include(helpful_url)
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#reg_reminder" do
    let(:mail) { UserMailer.reg_reminder(user) }

    it "includes some helpful links" do
      expect(mail.body).to include(helpful_url)
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end

  describe "#deadline_reminder" do
    let(:category) { FactoryGirl.build(:category) }
    let(:deadline) { Deadline.new(category: category, user: user, target_completed_on: "2099-01-01") }
    let(:mail) { UserMailer.deadline_reminder(deadline) }

    it "tells you about your deadline" do
      expect(mail.body).to include(category.name)
      expect(mail.body).to include("2099-01-01")
      expect(mail.body).to include("/#{category.handle}.html")
    end

    it "actually sends the email" do
      expect { mail.deliver_now! }.to change { deliveries }.by(1)
    end
  end


  def deliveries
    ActionMailer::Base.deliveries.size
  end
end
