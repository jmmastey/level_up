require "spec_helper"

describe AdminMailer do
  let(:user) { build(:user) }
  let(:course) { build(:course) }
  let(:mail) { AdminMailer.confirm_enrollment(user, course) }

  it "confirms course enrollment" do
    expect(mail.to).to include(ENV["ADMIN_EMAIL"])
    expect(mail.body).to include(user.email)
    expect(mail.body).to include(course.name)
  end

  it "actually sends the email" do
    expect { mail.deliver! }.to change { deliveries }.by(1)
  end

  def deliveries
    ActionMailer::Base.deliveries.size
  end
end
