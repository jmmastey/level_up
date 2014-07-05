require 'spec_helper'

describe Skill do

  describe "feed_for" do

    let(:user) { build(:user) }
    let(:skill) { build(:skill) }
    let!(:completion) { create(:completion, user: user, skill: skill) }

    it "should return the recently completed skill" do
      #Skill.feed_for(user).should include(skill)
      pending 'not implemented'
    end

  end

end
