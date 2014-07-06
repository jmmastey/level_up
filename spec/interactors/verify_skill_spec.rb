require 'spec_helper'

describe VerifySkill do
  let(:user)      { create(:user) }

  it "allows the user to verify another user's skill"
  it "only verifes skills with claimed completions"
end
