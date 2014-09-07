require 'spec_helper'

describe SkillsController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  let(:skill) { FactoryGirl.create(:skill) }

  describe "POST 'completion'" do
    it "returns an unsuccessful response when passed an invalid skill" do
      expect(CompleteSkill).not_to receive(:perform)

      post 'complete', skill_id: -1

      expect(response).to be_client_error
      expect(response.content_type).to eq("application/json")
      body = JSON(response.body)
      expect(body['success']).to be false
      expect(body['error']).to match('provide a valid skill')
    end

    it "returns an unsuccessful response when the action fails" do
      interactor = double('CompleteSkill')
      expect(interactor).to receive(:success?).and_return(false)
      expect(interactor).to receive(:message).and_return("invalid!")
      expect(CompleteSkill).to receive(:perform).and_return(interactor)

      post 'complete', skill_id: skill.id

      expect(response).to be_client_error
      body = JSON(response.body)
      expect(body['success']).to be false
      expect(body['error']).to match("invalid!")
    end

    it "returns a successful response when passed a skill" do
      interactor = double("CompleteSkill")
      expect(interactor).to receive(:success?).and_return(true)
      expect(CompleteSkill).to receive(:perform).and_return(interactor)

      post 'complete', skill_id: skill.id

      expect(response).to be_success
      body = JSON(response.body)
      expect(body['success']).to be true
      expect(body['complete']).to be true
    end

  end

  describe "DELETE 'completion'" do
    it "returns an unsuccessful response when passed an invalid skill" do
      expect(UncompleteSkill).not_to receive(:perform)

      delete 'uncomplete', skill_id: -1

      expect(response).to be_client_error
      expect(response.content_type).to eq("application/json")
      body = JSON(response.body)
      expect(body['success']).to be false
      expect(body['error']).to match('provide a valid skill')
    end

    it "returns an unsuccessful response when the action fails" do
      interactor = double('UncompleteSkill')
      expect(interactor).to receive(:success?).and_return(false)
      expect(interactor).to receive(:message).and_return("invalid!")
      expect(UncompleteSkill).to receive(:perform).and_return(interactor)

      delete 'uncomplete', skill_id: skill.id

      expect(response).to be_client_error
      body = JSON(response.body)
      expect(body['success']).to be false
      expect(body['error']).to match("invalid!")
    end

    it "returns a successful response when passed a skill" do
      interactor = double("UncompleteSkill")
      expect(interactor).to receive(:success?).and_return(true)
      expect(UncompleteSkill).to receive(:perform).and_return(interactor)

      delete 'uncomplete', skill_id: skill.id

      expect(response).to be_success
      body = JSON(response.body)
      expect(body['success']).to be true
      expect(body['complete']).to be false
    end

  end

end
