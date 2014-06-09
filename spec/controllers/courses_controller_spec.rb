require 'spec_helper'

describe CoursesController, type: :controller do

  describe "GET index" do
    let!(:course) { create(:course) }
    let!(:published_course) { create(:course, :published) }

    describe "while not logged in" do
      it "should render only publicly available courses" do
        get "index"
        response.should render_template(:index)
        assigns(:courses).should eq([ published_course ])
      end
    end

    describe "while logged in" do
      before (:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "should render the list of available courses" do
        User.any_instance.should_receive(:courses).and_return([course, published_course])

        get "index"
        response.should render_template(:index)
        assigns(:courses).should include(course)
        assigns(:courses).should include(published_course)
      end
    end

  end

end
