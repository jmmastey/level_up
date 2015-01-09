require 'spec_helper'

describe CourseActivity do
  let(:course) { create(:course, :with_skills) }
  let(:enrollment) { create(:enrollment, course: course) }
  let(:user) { enrollment.user }

  let(:skill1) { course.skills.first }
  let(:skill2) { course.skills.last }

  subject(:course_activity) { CourseActivity.new(enrollment) }

  describe ".last_completion_for" do
    it "grabs the most recent completion" do
      create(:completion, user: user, skill: skill1)
      completion = create(:completion, user: user, skill: skill2)

      expect(course_activity.last_completion).to eq(completion)
    end

    it "returns nil when there are no completions" do
      course_activity = CourseActivity.new(create(:enrollment))
      expect(course_activity.last_completion).to be_nil
    end
  end

  describe ".last_activity_date" do
    it "returns the last completion date when one is present" do
      completion = create(:completion, user: user, skill: skill2)
      expect(course_activity.last_activity_date).to eq(completion.created_at)
    end

    it "returns the enrollment date when there aren't completions" do
      enrollment = create(:enrollment)
      course_activity = CourseActivity.new(enrollment)
      expect(course_activity.last_activity_date).to eq(enrollment.created_at)
    end
  end
end
