require File.expand_path("../lib/zonebie", File.dirname(__FILE__))

require "mocha"
RSpec.configure do |c|
  c.mock_with :mocha

  c.before do
    ENV.delete('TZ')
    Zonebie.backend = nil # reset to default
  end
end
