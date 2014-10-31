require 'spec_helper'

describe Completion do

  describe "feed_for" do
    let(:user) { build(:user) }
    let!(:completion) { create(:completion, user: user) }

    it "returns the recently completed skill" do
      expect(Completion.feed_for(user)).to include(completion)
    end

    it "decorates completions as requested" do
      decorated_item = Completion.decorated_feed_for(user).first
      expect(decorated_item[:item]).to eql(completion)
      expect(decorated_item[:tags]).to include("skill-#{completion.skill.handle}")
      expect(decorated_item[:label]).to match(/#{completion.skill.name}/)
    end

  end

end
