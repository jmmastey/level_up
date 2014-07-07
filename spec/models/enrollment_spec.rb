require 'spec_helper'

describe Enrollment do

  describe "feed_for" do
    let(:user) { build(:user) }
    let!(:enrollment) { create(:enrollment, user: user) }

    it "returns the recently completed enrollment" do
      expect(Enrollment.feed_for(user)).to include(enrollment)
    end

    it "decorates enrollments as requested" do
      decorated_item = Enrollment.decorated_feed_for(user).first

      expect(decorated_item[:item]).to eql(enrollment)
      expect(decorated_item[:tags]).to include(enrollment.course.handle)
      expect(decorated_item[:label]).to match(/#{enrollment.course.name}/)
    end

  end

end
