require 'spec_helper'

describe Completion do

  describe "feed_for" do

    let(:user) { build(:user) }
    let!(:completion) { create(:completion, user: user) }

    it "returns the recently completed skill" do
      expect(Completion.feed_for(user)).to include(completion)
    end

  end

end
