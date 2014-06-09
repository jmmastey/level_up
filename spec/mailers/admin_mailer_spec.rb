require "spec_helper"

describe AdminMailer do
  let(:user) { build(:user) }
  let(:course) { build(:course) }

  let(:mail) { AdminMailer.confirm_enrollment(user, course) }

  it "should confirm course enrollment" do
    mail.to.should include(ENV["ADMIN_EMAIL"])
    mail.body.should include(user.email)
    mail.body.should include(course.name)
  end

  it "should actually send the email" do
    expect { mail.deliver! }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end
end
