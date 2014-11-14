require 'spec_helper'

describe HomeController, type: :controller do
  render_views

  def self.extant_partials
    Dir["#{Rails.root}/app/views/modules/_*.html.haml"].map do |category|
      next if category =~ /resources|exercises/
      category.scan(/_([a-z_]*).html.haml/).first.first
    end.compact
  end

  extant_partials.each do |category|
    next if ["faux"].include? category

    it "shows the #{category} page properly" do
      get :show, module: category

      expect(response.code).to eq("200")
      expect(response.body).to include(category)
    end
  end
end
