require 'spec_helper'

describe Completion do
  let(:user)  { create(:user) }
  let(:skill) { create(:skill) }

  describe ".feed_for" do
    it "returns the recently completed skill" do
      completion = create(:completion, skill: skill, user: user)

      result = Completion.feed_for(user)

      expect(result).to include(completion)
    end

    it "decorates completions as requested" do
      completion = build_stubbed(:completion, skill: skill)
      allow(Completion).to receive(:feed_for) { [completion] }

      decorated_item = Completion.decorated_feed_for(user).first

      expect(decorated_item[:item]).to eql(completion)
      expect(decorated_item[:tags]).to include("skill-#{skill.handle}")
      expect(decorated_item[:label]).to include(skill.name)
    end
  end

  describe ".for" do
    it "searches for the specified completion" do
      allow(Completion).to receive(:find_by) { nil }

      Completion.for(user, skill)

      expect(Completion).to have_received(:find_by).with(user: user, skill: skill)
    end

    it "returns nil when there is no completion" do
      allow(Completion).to receive(:find_by) { nil }

      result = Completion.for(user, skill)

      expect(result).to be_nil
    end
  end

  describe ".for!" do
    it "searches for the specified completion" do
      allow(Completion).to receive(:find_by) { build(:completion) }

      Completion.for!(user, skill)

      expect(Completion).to have_received(:find_by).with(user: user, skill: skill)
    end

    it "raises when there is no completion" do
      allow(Completion).to receive(:for) { nil }

      expect { Completion.for!(user, skill) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".for_course" do
    let(:category) { create(:category, skills: [skill]) }
    let(:course) { create(:course, categories: [category]) }

    it "returns relevant completions" do
      completion = create(:completion, user: user, skill: skill)

      result = Completion.for_course(user, course).last

      expect(result).to eq(completion)
    end
  end
end
