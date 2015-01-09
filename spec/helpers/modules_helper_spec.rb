require 'spec_helper'

describe ModulesHelper, type: :helper do
  let(:course) { create(:course, :with_skills) }
  let(:category) { course.categories.first }
  let(:skill) { category.skills.last }
  let(:user) { create(:user) }
  let(:guest) { Guest.new }

  def enroll_user(created_at = Date.today)
    create(:enrollment, user: user, course: course, created_at: created_at)
  end

  def complete_skill(created_at = Date.today, user = user, skill = skill)
    create(:completion, user: user, skill: skill, created_at: created_at)
  end

  describe "#user_is_stuck?" do
    it "returns false for guests" do
      stuck = helper.user_is_stuck?(guest, category)
      expect(stuck).to be_falsy
    end

    it "returns false for unenrolled users" do
      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_falsy
    end

    it "returns false for recently enrolled users" do
      enroll_user

      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_falsy
    end

    it "returns false when last activity is recent" do
      enroll_user
      complete_skill

      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_falsy
    end

    it "returns false when the user completed the module" do
      enroll_user(3.weeks.ago)
      category.skills.each do |skill|
        complete_skill(3.weeks.ago, user, skill)
      end

      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_falsy
    end

    it "returns true when enrollment is super old" do
      enroll_user(3.weeks.ago)

      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_truthy
    end

    it "returns true when last activity is way old" do
      enroll_user(3.weeks.ago)
      complete_skill(3.weeks.ago, user, skill)

      stuck = helper.user_is_stuck?(user, category)
      expect(stuck).to be_truthy
    end
  end
end
