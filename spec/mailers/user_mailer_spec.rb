require "spec_helper"

describe UserMailer do
  let(:user) { build(:user) }
  let(:course) { build(:course) }
  let(:mail) { UserMailer.confirm_enrollment(user, course) }

  it "confirms course enrollment" do
    expect(mail.to).to include(user.email)
    expect(mail.body).to include(course.name)
  end

  it "actually sends the email" do
    expect { mail.deliver! }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
end
