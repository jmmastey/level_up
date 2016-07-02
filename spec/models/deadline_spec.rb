require 'spec_helper'

describe Deadline do
  subject(:deadline) { described_class }

  describe '#estimate' do
    it "estimates a deadline date" do
      cat = instance_double(Category, difficulty: 3)

      result = deadline.estimate(cat).to_date

      expect(result).to eq(Date.today + 6.days)
    end
  end
end
