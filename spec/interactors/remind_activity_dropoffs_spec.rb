require 'spec_helper'

describe RemindActivityDropoffs do
  subject(:interactor) { described_class.new(user_mailer: umailer) }
  let(:course)  { create(:course, :with_skills) }
  let(:umailer) { class_spy(UserMailer, present?: true, activity_reminder: spy) }
  let!(:enroll) { create(:enrollment, course: course, created_at: 1.year.ago) }

  it "sends email to users who've become stuck" do
    allow(interactor).to receive(:targets) { [enroll] }

    interactor.call

    expect(umailer).to have_received(:activity_reminder).with(enroll)
  end

  it "finds only enrolled but stuck users" do
    old = create(:enrollment, course: course, created_at: 1.year.ago)
    create(:enrollment, course: course, created_at: 1.day.ago)
    create(:enrollment) # no skills, fucker
    allow(interactor).to receive(:remind)

    interactor.call

    expect(interactor).to have_received(:remind).once.with(old)
  end

  it "sends emails only once" do
    allow(interactor).to receive(:remind)

    interactor.call.call

    expect(interactor).to have_received(:remind).with(enroll)
  end
end
