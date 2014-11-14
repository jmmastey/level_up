require 'spec_helper'

describe HomeController, type: :controller do
  let(:email) { "bill@microsoft.com" }
  let(:token) { "hunter2" }

  let(:auth_hash) { { auth_email: email, auth_token: token } }

  it "authenticates the user via token as requested" do
    expect(User).to receive(:from_token_auth).with(auth_hash)

    get :index, auth_hash

  end

  it "only authenticates if params are provided" do
    expect(User).not_to receive(:from_token_auth)
    get :index, {}
  end
end
