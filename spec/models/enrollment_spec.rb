require 'spec_helper'

describe Enrollment do
  describe "feed_for" do
    it "returns the recently completed enrollment" do
      enrollment = create(:enrollment, created_at: 1.day.ago)

      expect(Enrollment.feed_for(enrollment.user)).to include(enrollment)
    end

    it "decorates enrollments as requested" do
      enrollment = build_stubbed(:enrollment)
      allow(Enrollment).to receive(:feed_for) { [enrollment] }

      result = Enrollment.decorated_feed_for(enrollment.user).first

      expect(result[:item]).to eql(enrollment)
      expect(result[:tags]).to include(enrollment.course.handle)
      expect(result[:label]).to match(/#{enrollment.course.name}/)
    end
  end
end
