require 'spec_helper'

describe CourseActivity, type: :model do
  describe "#user_is_stuck?" do
    let(:course) { create(:course, :with_skills) }
    let(:user) { create(:user) }

    def activity(user, course)
      CourseActivity.new(user, course)
    end

    def create_completion(date, skill = course.skills.last)
      create(:completion, created_at: date, user: user, skill: skill)
    end

    def enroll(date, course = course)
      create(:enrollment, user: user, course: course, created_at: date)
    end

    it "returns false for guests" do
      expect(activity(Guest.new, course).user_is_stuck?).to be_falsy
    end

    it "returns false for users who aren't enrolled" do
      # no enroll()
      expect(activity(user, course).user_is_stuck?).to be_falsy
    end

    it "returns false when the user has completed the module" do
      enroll(2.weeks.ago)
      course.skills.each { |s| create_completion(2.weeks.ago, s) }

      expect(activity(user, course).user_is_stuck?).to be_falsy
    end

    it "returns false when the user has recent completions" do
      enroll(2.weeks.ago)
      create_completion(1.day.ago)

      expect(activity(user, course).user_is_stuck?).to be_falsy
    end

    it "returns false when the user enrolled recently" do
      enroll(1.day.ago)
      expect(activity(user, course).user_is_stuck?).to be_falsy
    end

    it "returns true when the last completion is super old" do
      enroll(2.weeks.ago)
      create_completion(2.weeks.ago)

      expect(activity(user, course).user_is_stuck?).to be_truthy
    end

    it "returns true when the registration is old and w/ no completions" do
      enroll(2.weeks.ago)
      expect(activity(user, course).user_is_stuck?).to be_truthy
    end
  end
end
