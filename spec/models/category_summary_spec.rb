require 'spec_helper'

describe CategorySummary do
  let(:user) { create(:user) }
  let!(:course) { create(:course, :with_skills) }
  let!(:enrollment) { create(:enrollment, course: course, user: user) }
  let!(:completion) { create(:completion, :verified, skill: skill, user: user) }

  let(:skill) { course.skills.first }
  let(:category) { skill.category }

  describe "user_summary" do
    it "lists all categories that exist" do
      summary = CategorySummary.user_summary(user)
      expect(summary).to have(Category.count).items
    end

    it "counts skills, completions and verifications" do
      summary = CategorySummary.user_summary(user)[category.handle]
      expect(summary[:total_skills]).to eq(category.skills.length)
      expect(summary[:total_completed]).to eq(1)
      expect(summary[:total_verified]).to eq(1)
    end
  end

  describe "#course_summary" do
    it "transforms the user summary per course categories" do
      summary = CategorySummary.course_summary(course, user)
      expect(summary[:total]).to eq(course.skills.length)
      expect(summary[:completed]).to eq(1)
      expect(summary[:verified]).to eq(1)
    end
  end

  describe "#category_summary" do
    it "tracks completion across categories" do
      summary = CategorySummary.category_summary(user)
    end
  end

end
