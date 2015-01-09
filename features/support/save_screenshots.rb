require_relative 'spec_helper'

RSpec.configure do |config|
  config.after(:each) do
    if example.exception && example.metadata[:js]
      meta = example.metadata
      filename = File.basename(meta[:file_path])
      line_number = meta[:line_number]
      screenshot_name = "screenshot-#{filename}-#{line_number}.png"
      screenshot_path = "#{Rails.root.join('tmp')}/#{screenshot_name}"

      page.save_screenshot(screenshot_path)

      puts meta[:full_description] + "\n  Screenshot: #{screenshot_path}"
    end
  end
end
