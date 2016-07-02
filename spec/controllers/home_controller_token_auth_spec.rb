require 'spec_helper'

describe HomeController, type: :controller do
  let(:email) { "bill@microsoft.com" }
  let(:token) { "hunter2" }

  let(:auth_hash) { { auth_email: email, auth_token: token } }

  it "authenticates the user via token as requested" do
    allow(User).to receive(:from_token_auth)

    get :index, params: auth_hash

    expect(User).to have_received(:from_token_auth).with(auth_hash)
  end

  it "only authenticates if params are provided" do
    allow(User).to receive(:from_token_auth)

    get :index, params: {}

    expect(User).not_to have_received(:from_token_auth)
  end
end
