require 'rspec/rails'
RSpec.configure do |config|

  # sadface that they don't like should aynmore.
  config.mock_with :rspec do |c| c.syntax = [:should, :expect] end
  config.expect_with :rspec do |c| c.syntax = [:should, :expect] end

end
