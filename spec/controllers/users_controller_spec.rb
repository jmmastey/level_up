require 'spec_helper'

describe UsersController, type: :controller  do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'index'" do
    it "returns a successful response with users" do
      expect(User).to receive(:by_activity_date).and_call_original
      get :index

      expect(response).to render_template(:index)
      expect(assigns(:users)).to include(@user)
    end
  end

  describe "GET 'show'" do
    it "is successful" do
      get :show, id: @user.id
      expect(response).to be_success
    end

    it "finds the right user" do
      get :show, id: @user.id
      expect(assigns(:user)).to eq(@user)
    end
  end
end
