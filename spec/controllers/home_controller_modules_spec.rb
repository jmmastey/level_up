require 'spec_helper'

describe HomeController, type: :controller do
  def self.extant_partials
    Dir["#{Rails.root}/app/views/modules/[a-z]*.html.haml"].map do |mod|
      mod.split('/').last.gsub(/\..*/, '')
    end
  end

  extant_partials.each do |mod|
    # there are some conjecture or test-based partials, so skip those
    next unless Category.where(handle: mod).exists?

    it "shows the #{mod} page properly" do
      expect { get :show, module: mod }.not_to raise_error
    end
  end
end
