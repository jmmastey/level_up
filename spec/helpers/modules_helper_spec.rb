require 'spec_helper'

describe ModulesHelper, type: :helper do
  let(:course) { create(:course) }
  let(:skill) { course.skills.last }
  let(:user) { create(:user) }
  let(:guest) { Guest.new }

  describe "#user_is_stuck?" do
    it "returns false for guests" do
      stuck = helper.user_is_stuck?(guest, course)
      expect(stuck).to be_falsy
    end

    it "returns false for unenrolled users" do
      stuck = helper.user_is_stuck?(user, course)
      expect(stuck).to be_falsy
    end

    it "returns false for recently enrolled users" do
      create(:enrollment, user: user, course: course)

      stuck = helper.user_is_stuck?(user, course)
      expect(stuck).to be_falsy
    end

    it "returns false when last activity is recent" do
      create(:enrollment, user: user, course: course)
      create(:completion, user: user, skill: skill)

      stuck = helper.user_is_stuck?(user, course)
      expect(stuck).to be_falsy
    end

    it "returns true when enrollment is super old" do
      create(:enrollment, user: user, course: course, created_at: 3.weeks.ago)

      stuck = helper.user_is_stuck?(user, course)
      expect(stuck).to be_truthy
    end

    it "returns true when last activity is way old" do
      create(:enrollment, user: user, course: course)
      create(:completion, user: user, skill: skill, created_at: 3.weeks.ago)

      stuck = helper.user_is_stuck?(user, course)
      expect(stuck).to be_truthy
    end
  end
end
