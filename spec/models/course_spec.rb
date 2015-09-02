require 'spec_helper'

describe Course do
  describe "#published" do
    it "is not published by default" do
      course = create(:course)
      published_course = create(:course, :published)

      published = Course.published
      expect(published).not_to include(course)
      expect(published).to include(published_course)
    end

    it "can be published" do
      course = create(:course)
      course.publish!

      expect(Course.published).to include(course)
    end
  end

  describe "#categories" do
    let(:course) { create(:course) }
    let(:category) { create(:category) }

    it "doesn't belong to any categories by default" do
      expect(course.categories).to be_empty
    end
  end

  describe "#available_to" do
    let(:user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:employee) { create(:user, organization: "toool") }

    let!(:proprietary) { create(:course, :published, organization: "toool") }
    let!(:published) { create(:course, :published) }
    let!(:hidden) { create(:course, :created) }

    it "retrieves enrolled courses" do
      expect(Course.available_to(user)).to include(published)

      Enrollment.create(course: hidden, user: user)
      user.reload # saaaad
      expect(Course.available_to(user)).to include(hidden)
    end

    it "shows all courses to admins, but not to other users" do
      expect(Course.available_to(user)).to include(published)
      expect(Course.available_to(admin)).to include(published, hidden)
    end

    it "only shows org courses to admins and org users" do
      expect(Course.available_to(user)).not_to include(proprietary)
      expect(Course.available_to(admin)).to include(proprietary)
      expect(Course.available_to(employee)).to include(proprietary)
    end
  end
end
