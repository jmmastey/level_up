require 'spec_helper'

describe CoursesController, type: :controller do

  describe "GET index" do
    let!(:course) { create(:course) }
    let!(:published_course) { create(:course, :published) }

    describe "while not logged in" do
      it "renders only publicly available courses" do
        get "index"
        expect(response).to render_template(:index)
        expect(assigns(:courses)).to eq([published_course])
      end
    end

    describe "while logged in" do
      before :each do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "renders the list of available courses" do
        expect(Course).to receive(:available_to).and_return([course, published_course])

        get "index"
        expect(response).to render_template(:index)
        expect(assigns(:courses)).to include(course)
        expect(assigns(:courses)).to include(published_course)
      end
    end

  end

end
