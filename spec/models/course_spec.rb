require 'spec_helper'

describe Course do

  describe "publishing" do
    it "should not be public by default" do
      course = create(:course)
      published_course = create(:course, :published)
      Course.published.should_not include(course)
      Course.published.should include(published_course)
    end

    it "should allow publishing" do
      course = create(:course)
      course.publish!

      Course.published.should include(course)
    end
  end

  describe "categories" do
    let(:course) { create(:course) }
    let(:category) { create(:category) }

    it "should not belong to any categories by default" do
      course.categories.should be_empty
    end

    it "should belong to the categories of its skills" do
      create(:skill, category: category, courses: [course])
      course.categories.should eq([category])
    end
  end

  describe "course visibility" do
    let(:user) { create(:user) }
    let!(:published) { create(:course, :published) }
    let!(:hidden) { create(:course, :created) }

    it "should retrieve enrolled courses" do
      expect(Course.available_to(user)).to include(published)

      Enrollment.create(course: hidden, user: user)
      user.reload # saaaad
      expect(Course.available_to(user)).to include(hidden)
    end

    it "should show all courses to admins, but not to other users" do
      expect(Course.available_to(user)).to eq([published])

      user.add_role(:admin)
      expect(Course.available_to(user)).to eq([published, hidden])
    end

  end
end
