require 'spec_helper'

describe UserSummary do
  let(:user) { create(:user) }
  let!(:course) { create(:course, :with_skills) }
  let!(:enrollment) { create(:enrollment, course: course, user: user) }
  let!(:completion) { create(:completion, :verified, skill: skill, user: user) }

  let(:skill) { course.skills.first }
  let(:category) { skill.category }

  describe "for_user" do
    it "lists all categories that exist" do
      summary = UserSummary.new(user).for_user
      expect(summary.length).to eq(course.categories.count)
    end

    it "counts skills, completions and verifications" do
      summary = UserSummary.new(user).for_category(category)
      expect(summary[:total_skills]).to eq(category.skills.count)
      expect(summary[:total_completed]).to eq(1)
      expect(summary[:total_verified]).to eq(1)
    end

    it "only tracks your completion stats" do
      create(:completion, skill: category.skills.first)

      summary = UserSummary.new(user).for_category(category)
      expect(summary[:total_skills]).to eq(category.skills.count)
      expect(summary[:total_completed]).to eq(1)
    end
  end

  describe "#for_course" do
    it "transforms the user summary per course categories" do
      summary = UserSummary.new(user).for_course(course)
      expect(summary[:total]).to eq(course.skills.count)
      expect(summary[:completed]).to eq(1)
      expect(summary[:verified]).to eq(1)
    end
  end

  describe "#for_category" do
    it "returns empty if you aren't enrolled" do
      cat = double(skills: Skill.all, handle: "foo")
      summary = UserSummary.new(user).for_category(cat)

      expect(summary[:total_skills]).to eq(Skill.count)
      expect(summary[:total_completed]).to eq(0)
      expect(summary[:total_verified]).to eq(0)
    end
  end
end
