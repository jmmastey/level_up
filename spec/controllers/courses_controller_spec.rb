require 'spec_helper'

describe CoursesController do
  let(:course) { FactoryGirl.create(:course) }
  let(:public_course) do
    course = FactoryGirl.create(:course)
    course.make_public!
    course
  end

  describe "GET index" do
    it "should render the list of available courses" do
      current_user = double("current user")
      current_user.should_receive(:courses).and_return([course])
      controller.should_receive(:current_user).and_return(current_user)

      get "index"
      response.should render_template("index")
    end

  end

end
