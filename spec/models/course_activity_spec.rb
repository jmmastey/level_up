require 'spec_helper'

describe CourseActivity, type: :model do
  describe "#user_is_stuck?" do
    let(:category) { create(:category, :skilled) }
    let(:user) { create(:user) }

    def activity(user, category)
      CourseActivity.new(user, category)
    end

    def create_completion(date, skill = category.skills.last)
      create(:completion, created_at: date, user: user, skill: skill)
    end

    def enroll(date, course = category.course)
      create(:enrollment, user: user, course: course, created_at: date)
    end

    it "returns false for guests" do
      expect(activity(Guest.new, category).user_is_stuck?).to be_falsy
    end

    it "returns false for users who aren't enrolled" do
      # no enroll()
      expect(activity(user, category).user_is_stuck?).to be_falsy
    end

    it "returns false when the user has completed the module" do
      enroll(2.weeks.ago)
      category.skills.each { |s| create_completion(2.weeks.ago, s) }

      expect(activity(user, category).user_is_stuck?).to be_falsy
    end

    it "returns false when the user has recent completions" do
      enroll(2.weeks.ago)
      create_completion(1.day.ago)

      expect(activity(user, category).user_is_stuck?).to be_falsy
    end

    it "returns false when the user enrolled recently" do
      enroll(1.day.ago)
      expect(activity(user, category).user_is_stuck?).to be_falsy
    end

    it "returns true when the last completion is super old" do
      enroll(2.weeks.ago)
      create_completion(2.weeks.ago)

      expect(activity(user, category).user_is_stuck?).to be_truthy
    end

    it "returns true when the registration is super old but there are no completions" do
      enroll(2.weeks.ago)
      expect(activity(user, category).user_is_stuck?).to be_truthy
    end
  end
end
