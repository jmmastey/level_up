require 'spec_helper'

describe SkillsController do
  login_user

  let(:skill) { FactoryGirl.create(:skill) }

  describe "POST 'complete'" do
    it "returns an unsuccessful response when passed an invalid skill" do
      CompleteSkill.should_not_receive(:perform)

      post "complete", skill_id: -1

      response.should be_client_error
      response.content_type.should eq("application/json")
      body = JSON(response.body)
      body['success'].should be_false
      body['error'].should match('provide a valid skill')
    end

    it "returns an unsuccessful response when the action fails" do
      interactor = double('CompleteSkill')
      interactor.should_receive(:success?).and_return(false)
      interactor.should_receive(:message).and_return("invalid!")
      CompleteSkill.should_receive(:perform).and_return(interactor)

      post "complete", :skill_id => skill.id

      response.should be_client_error
      body = JSON(response.body)
      body['success'].should be_false
      body['error'].should match("invalid!")
    end

    it "returns a successful response when passed a skill" do
      interactor = double("CompleteSkill")
      interactor.should_receive(:success?).and_return(true)
      CompleteSkill.should_receive(:perform).and_return(interactor)

      post 'complete', skill_id: skill.id

      response.should be_success
      body = JSON(response.body)
      body['success'].should be_true
    end

  end

end
