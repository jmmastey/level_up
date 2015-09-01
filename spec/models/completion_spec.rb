require 'spec_helper'

describe Completion do
  let(:user) { create(:user) }
  let(:skill) { create(:skill) }
  let(:incomplete_skill) { create(:skill) }
  let!(:completion) { create(:completion, skill: skill, user: user) }

  describe ".feed_for" do
    it "returns the recently completed skill" do
      expect(Completion.feed_for(user)).to include(completion)
    end

    it "decorates completions as requested" do
      decorated_item = Completion.decorated_feed_for(user).first
      expect(decorated_item[:item]).to eql(completion)
      expect(decorated_item[:tags]).to include("skill-#{skill.handle}")
      expect(decorated_item[:label]).to include(skill.name)
    end
  end

  describe ".for" do
    it "returns the specified completion" do
      expect(Completion.for(user, skill)).to eq(completion)
    end

    it "returns nil when there is no completion" do
      expect(Completion.for(user, incomplete_skill)).to be_nil
    end
  end

  describe ".for!" do
    it "returns the specified completion" do
      expect(Completion.for!(user, skill)).to eq(completion)
    end

    it "raises when there is no completion" do
      expect { Completion.for!(user, incomplete_skill) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".for_course" do
    let(:category) { create(:category, skills: [skill]) }
    let(:course) { create(:course, categories: [category]) }

    it "returns relevant completions" do
      expect(Completion.for_course(user, course).last).to eq(completion)
    end
  end
end
