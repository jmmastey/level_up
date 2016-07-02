require 'spec_helper'

class Dummy
  include CategoryRouter
end

describe CategoryRouter do
  subject(:dummy) { Dummy.new }

  describe ".find_category!" do
    it "raises if user isn't in the right org" do
      params  = { category: "america", organization: "sharks" }
      user    = instance_double(User, admin?: false, organization: "jets")

      expect do
        subject.find_category!(params, user)
      end.to raise_error(WrongOrganizationError)
    end

    it "doesn't care if the category doesn't belong to an organization" do
      params  = { category: "america" }
      user    = instance_double(User, admin?: false)
      klass   = class_spy(Category, find_by!: "fie!")

      expect { subject.find_category!(params, user, klass) }.not_to raise_error
    end

    it "allows admins through regardless" do
      params  = { category: "america", organization: "sharks" }
      user    = instance_double(User, admin?: true, organization: "jets")
      klass   = class_double(Category, find_by!: "fie!")

      expect { subject.find_category!(params, user, klass) }.not_to raise_error
    end

    it "looks for the category when bidden" do
      params  = { category: "america", organization: "sharks" }
      user    = instance_double(User, admin?: false, organization: "sharks")
      klass   = class_spy(Category)

      subject.find_category!(params, user, klass)

      expected_vals = hash_including(handle: "america", organization: "sharks")
      expect(klass).to have_received(:find_by!).with(expected_vals)
    end
  end

  describe "#path_for" do
    subject(:router) { CategoryRouter }

    it "uses helpers" do
      helpers = spy
      cat     = instance_double(Category, organization: "org", handle: "handle")

      subject.path_for(cat, helpers)

      expected_vals = hash_including(category: "handle", organization: "org")
      expect(helpers).to have_received(:category_path).with(expected_vals)
    end
  end
end
