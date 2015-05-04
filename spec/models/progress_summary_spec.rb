require 'spec_helper'

describe ProgressSummary do

  before do
    FactoryGirl.create(:enrollment, created_at: oldest_date)
    FactoryGirl.create(:enrollment, created_at: oldest_date+1)
  end

  let(:enrollments)     { Enrollment.all }
  let(:num_enrollments) { enrollments.count }
  let(:oldest_date)     { 1.year.ago }

  subject { described_class.new enrollments }

  def subject_with(*args)
    described_class.new(*args)
  end

  describe "#start_date" do
    let(:start_date) { 2.months.ago }

    it "has a start date that is the oldest enrollment date" do
      expect(subject.start_date).to eq(oldest_date)
    end

    it "has a specified start date if you provide it" do
      subject = subject_with(enrollments, start_date: start_date)
      expect(subject.start_date).to eq(start_date)
    end
  end

  describe "#end_date" do
    let(:end_date) { 2.months.from_now }

    it "has an end date of today by default" do
      expect(subject.end_date).to eq(Date.today)
    end

    it "has a specified end date if you provide it" do
      subject = subject_with(enrollments, end_date: end_date)
      expect(subject.end_date).to eq(end_date)
    end
  end

  describe "#to_a" do
    it "returns an array of the correct length" do
      expect(subject.to_a).to have(num_enrollments).items
    end

    describe "result hash" do
      let(:enrollment_data) { subject.to_a.first }

      it "includes course info and progress" do
        expect(enrollment_data.keys).to include(:course_name, :progress)
      end

      it "reflects the course name" do
        expect(enrollment_data[:course_name])
      end

    end
  end

end
