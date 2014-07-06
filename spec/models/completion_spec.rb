require 'spec_helper'

describe Completion do

  describe "feed_for" do

    let(:user) { build(:user) }
    let!(:completion) { create(:completion, user: user) }

    it "should return the recently completed skill" do
      Completion.feed_for(user).should include(completion)
    end

  end

end
