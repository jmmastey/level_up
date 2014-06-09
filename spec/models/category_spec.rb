require 'spec_helper'

describe Category do

  describe "summarize_user" do
    before(:all) do
      create_list(:category, 4, :skilled)
    end

    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:skill) { create(:skill, category: category) }

    it "should list all categories that exist" do
      Category.summarize_user(user).length.should == 4
    end

    it "should have counts for skills" do
      summary = Category.summarize_user(user).values.first
      summary.should include(:total_skills)
      summary[:total_skills].should be(4)
    end

    it "should summarize completed and verified skills" do
      completion = create(:completion, :verified, user: user, skill: skill)
      summary = Category.summarize_user(user)

      summary[category.handle][:total_completed].should be(1)
      summary[category.handle][:total_verified].should be(1)

    end
  end

end
