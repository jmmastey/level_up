require 'spec_helper'

describe TokenAuthable do
  let(:auth_token) { "EXAMPLE_AUTH_TOKEN" }
  let(:user) { create(:user, authentication_token: auth_token) }

  describe "#authentication_token=" do
    it "sets the token to a bcrypt password object" do
      expect(user.authentication_token.chars.length).to eq(60)
    end
  end

  describe "#from_token_auth" do
    context "bad params" do
      let(:no_email_params)  { { auth_email: nil, auth_token: auth_token  } }
      let(:no_token_params)  { { auth_email: user.email, auth_token: nil  } }
      let(:bad_token_params) { { auth_email: user.email, auth_token: 'bad'  } }

      it "doesn't find any record without an email address" do
        result = User.from_token_auth(no_email_params)
        expect(result).to be_nil
      end

      it "doesn't find any record without a token" do
        result = User.from_token_auth(no_token_params)
        expect(result).to be_nil
      end

      it "doesn't find any record with a bad token" do
        result = User.from_token_auth(no_token_params)
        expect(result).to be_nil
      end
    end

    context "with good params" do
      let(:auth_params) { { auth_email: user.email, auth_token: auth_token  } }

      it "finds the right user when correct parameters are applied" do
        result = User.from_token_auth(auth_params)
        expect(result).to be_a(User)
      end
    end
  end
end
