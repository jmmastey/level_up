require 'spec_helper'

describe CategorySummary do

  describe "summarize_user" do
    before(:all) do
      create_list(:category, 4, :skilled)
    end

    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:skill) { create(:skill, category: category) }

    it "lists all categories that exist" do
      expect(CategorySummary.summarize_user(user)).to have(4).items
    end

    it "counts skills" do
      summary = CategorySummary.summarize_user(user).values.first
      expect(summary).to include(:total_skills)
      expect(summary[:total_skills]).to be(4)
    end

    it "summarizes completed and verified skills" do
      completion = create(:completion, :verified, user: user, skill: skill)
      summary = CategorySummary.summarize_user(user)

      expect(summary[category.handle][:total_completed]).to be(1)
      expect(summary[category.handle][:total_verified]).to be(1)
    end
  end

end
