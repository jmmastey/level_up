require 'pry'
require 'spec_helper'

describe ProgressSummary do
  before do
    create(:enrollment, created_at: oldest_date)
    create(:enrollment, created_at: oldest_date + 1)
  end

  let(:enrollments)     { Enrollment.all }
  let(:num_enrollments) { enrollments.count }
  let(:oldest_date)     { Date.today - 365 }

  subject { described_class.new enrollments }

  def subject_with(*args)
    described_class.new(*args)
  end

  describe "#start_date" do
    let(:start_date) { Date.today - 30 }

    it "has a start date that is the oldest enrollment date" do
      expect(subject.start_date).to be_kind_of(Date)
      expect(subject.start_date).to eq(oldest_date)
    end

    it "has a specified start date if you provide it" do
      subject = subject_with(enrollments, start_date: start_date)
      expect(subject.start_date).to be_kind_of(Date)
      expect(subject.start_date).to eq(start_date)
    end
  end

  describe "#end_date" do
    let(:end_date) { Date.today + 60 }

    it "has an end date of today by default" do
      expect(subject.end_date).to eq(Date.today)
    end

    it "has a specified end date if you provide it" do
      subject = subject_with(enrollments, end_date: end_date)
      expect(subject.end_date).to eq(end_date)
    end
  end

  describe "#to_a" do
    let(:enrollment_data) { subject.to_a.first }
    let(:enrollment) { Enrollment.first }

    it "returns an array of the correct length" do
      expect(subject.to_a.length).to eq(num_enrollments)
    end

    describe "result hash" do
      it "includes course info and progress" do
        expect(enrollment_data.keys).to include(:course_name, :progress)
      end

      it "reflects the course name" do
        expect(enrollment_data[:course_name]).to eq(enrollment.course.name)
      end

      it "has progress keys for each day in the range" do
        subject = subject_with(enrollments, start_date: Date.today,
                               end_date: Date.today + 3)
        data = subject.to_a.first
        dates = [Date.today, Date.today + 1, Date.today + 2, Date.today + 3]

        expect(data[:progress].length).to eq(4)
        expect(data[:progress].keys).to eq(dates)
      end
    end

    describe "dated results" do
      before do
        enrollments.each do |enrollment|
          enrollment.update!(course: course)
        end
      end

      let(:start_date) { enrollment.created_at.to_date }
      let(:course) { create(:course, :with_skills) }
      let(:total_skills) { course.skills.count }

      it "returns the total number of skills when there are no completions" do
        expect(enrollment_data[:progress][start_date]).to eq(total_skills)
        expect(enrollment_data[:progress][Date.today]).to eq(total_skills)
      end

      it "reduces the remaining count when a skill is completed" do
        create(:completion, created_at: start_date + 1,
               skill: course.skills.last, user: enrollment.user)

        progress = enrollment_data[:progress]

        expect(progress[start_date]).to eq(total_skills)
        expect(progress[start_date + 1]).to eq(total_skills - 1)
      end
    end
  end
end
