require 'spec_helper'

describe UnsubscribeLink do
  context "#for_user" do
    let(:user) { create(:user) }

    it "returns the current instance for a user when available" do
      UnsubscribeLink.create(user: user, token: "jimi-hendrix")
      expect(UnsubscribeLink.for_user(user).token).to eq("jimi-hendrix")
    end

    it "creates an instance if there isn't one available" do
      expect(UnsubscribeLink.for_user(user)).to be_an(UnsubscribeLink)
    end
  end
end
