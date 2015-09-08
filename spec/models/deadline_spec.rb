require 'spec_helper'

describe Deadline do
  subject(:deadline) { described_class }

  describe '#estimate' do
    it "estimates a deadline date" do
      cat = double(difficulty: 3)
      expect(deadline.estimate(cat).to_date).to eq(Date.today + 6.days)
    end
  end
end
