require 'spec_helper'

describe Course do

  describe "enrollment" do
    let(:user) { create(:user) }
    let(:course) { create(:course) }

    it "should not have any default enrollments" do
      course.users.should be_empty
    end

    it "should allow and store enrollment" do
      course.enroll!(user)
      course.users.should include(course)
    end
  end

  describe "publishing" do
    it "should not be public by default" do
      course = create(:course)
      published_course = create(:published_course)
      Course.published.should_not include(course)
      Course.published.should include(published_course)
    end

    it "should allow publishing" do
      course = create(:course)
      course.publish!

      Course.published.should include(course)
    end

  end
end
