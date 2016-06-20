require 'spec_helper'

describe CourseActivity, type: :model do
  describe "#user_is_stuck?" do
    let(:course) { create(:course, :with_skills) }
    let(:user) { build_stubbed(:user) }
    subject(:activity) { described_class.new(user, course) }

    it "returns false for guests" do
      service = described_class.new(Guest.new, course)

      result = service.user_is_stuck?

      expect(result).to be_falsy
    end

    it "returns false for users who aren't enrolled" do
      allow(Enrollment).to receive(:enrollment_date) { nil }

      result = subject.user_is_stuck?

      expect(result).to be_falsy
    end

    it "returns false when the user has completed the module" do
      mocked_completions = course.skills.map do |skill|
        build_stubbed(:completion, skill: skill)
      end
      allow(Completion).to receive(:for_category) { mocked_completions }
      allow(Enrollment).to receive(:enrollment_date) { 2.weeks.ago }

      result = subject.user_is_stuck?

      expect(result).to be_falsy
    end

    it "returns false when the user has recent completions" do
      allow(Completion).to receive(:for_category) { [build(:completion, created_at: 1.day.ago)] }
      allow(Enrollment).to receive(:enrollment_date) { 2.weeks.ago }

      result = subject.user_is_stuck?

      expect(result).to be_falsy
    end

    it "returns false when the user enrolled recently" do
      allow(Enrollment).to receive(:enrollment_date) { 1.day.ago }

      result = subject.user_is_stuck?

      expect(result).to be_falsy
    end

    it "returns true when the last completion is super old" do
      allow(Enrollment).to receive(:enrollment_date) { 2.weeks.ago }
      allow(Completion).to receive(:for_category) { [build(:completion, created_at: 2.weeks.ago)] }

      result = subject.user_is_stuck?

      expect(result).to be_truthy
    end

    it "returns true when the registration is old and w/ no completions" do
      allow(Enrollment).to receive(:enrollment_date) { 2.weeks.ago }

      result = subject.user_is_stuck?

      expect(result).to be_truthy
    end
  end
end
