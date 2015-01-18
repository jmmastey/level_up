require 'spec_helper'

class Dummy
  include CategoryRouter
end

describe CategoryRouter do
  subject(:dummy) { Dummy.new }

  describe ".find_category!" do
    it "raises if user isn't in the right org" do
      params  = { category: "america", organization: "sharks" }
      user    = double("User", organization: "jets")

      expect { subject.find_category!(params, user) }.to raise_error
    end

    it "doesn't care if the category doesn't belong to an organization" do
      params  = { category: "america" }
      user    = double("User")
      klass   = double("Category", organization: nil, find_by!: "fie!")

      expect { subject.find_category!(params, user, klass) }.not_to raise_error
    end

    it "looks for the category when bidden" do
      params  = { category: "america", organization: "sharks" }
      user    = double("User", organization: "sharks")
      klass   = double("Category", organization: nil, find_by!: nil)
      expected_vals = hash_including(handle: "america", organization: "sharks")

      expect(klass).to receive(:find_by!).with(expected_vals)
      subject.find_category!(params, user, klass)
    end
  end

  describe "#path_for" do
    subject(:router) { CategoryRouter }

    it "uses helpers" do
      helpers = double("UrlHelpers", category_path: nil)
      cat     = double("Category", organization: "org", handle: "handle")
      expected_vals = hash_including(handle: "handle", organization: "org")

      expect(helpers).to receive(:category_path).with(expected_vals)
      subject.path_for(cat, helpers)
    end
  end
end
