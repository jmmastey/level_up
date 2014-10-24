require 'spec_helper'

describe Summaries do
  let(:user) { create(:user) }
  let!(:course) { create(:course, :with_skills) }
  let!(:enrollment) { create(:enrollment, course: course, user: user) }
  let!(:completion) { create(:completion, :verified, skill: skill, user: user) }

  let(:skill) { course.skills.first }
  let(:category) { skill.category }

  describe "for_user" do
    it "lists all categories that exist" do
      summary = Summaries.for_user(user)
      expect(summary).to have(course.categories.count).items
    end

    it "counts skills, completions and verifications" do
      summary = Summaries.for_user(user)[category.handle]
      expect(summary[:total_skills]).to eq(category.skills.length)
      expect(summary[:total_completed]).to eq(1)
      expect(summary[:total_verified]).to eq(1)
    end

    it "only tracks your completion stats" do
      create(:completion, skill: category.skills.first)

      summary = Summaries.for_user(user)[category.handle]
      expect(summary[:total_skills]).to eq(category.skills.length)
      expect(summary[:total_completed]).to eq(1)
    end
  end

  describe "#for_course" do
    it "transforms the user summary per course categories" do
      summary = Summaries.for_course(course, user)
      expect(summary[:total]).to eq(course.skills.length)
      expect(summary[:completed]).to eq(1)
      expect(summary[:verified]).to eq(1)
    end
  end

end
