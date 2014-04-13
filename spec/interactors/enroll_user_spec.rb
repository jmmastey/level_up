require 'spec_helper'

describe EnrollUser do
  let(:course) { create(:course) }
  let(:user) { create(:user) }

  it "should allow a user to register for a course" do
    EnrollUser.any_instance.should_receive(:send_welcome_email).and_return(true)

    interactor = EnrollUser.perform(course: course, user: user)
    interactor.should be_success

    user.courses.should include(course)
  end

  it "should send welcome and notification emails" do
    #interactor = EnrollUser.perform(course: course, user: user)
  end

end
