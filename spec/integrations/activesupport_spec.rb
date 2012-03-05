require "spec_helper"
require "active_support/time"

describe Zonebie do
  before do
    Zonebie.backend = :activesupport
  end

  describe "#set_random_timezone" do
    it "assigns a random timezone" do
      ::Time.expects(:zone=).with do |zone|
        ActiveSupport::TimeZone.all.map(&:name).include? zone
      end

      $stdout.stubs(:puts)
      Zonebie.set_random_timezone
    end
  end
end
