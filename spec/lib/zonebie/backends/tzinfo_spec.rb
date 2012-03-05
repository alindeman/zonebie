require "spec_helper"

describe Zonebie::Backends::TZInfo do
  describe "#name" do
    it "is :tzinfo" do
      described_class.name.should == :tzinfo
    end
  end

  describe "#zones" do
    it "returns a list of zones provided by TZInfo" do
      ::TZInfo::Timezone.stubs(:all).
        returns([
          stub(:identifier => "America/Chicago"),
          stub(:identifier => "America/New York")
        ])

      described_class.zones.should =~ ["America/Chicago", "America/New York"]
    end
  end

  describe "#zone=" do
    it "is a noop" do
      $stderr.stubs(:puts)
      described_class.zone = "America/Chicago"
    end
  end

  describe "usable?" do
    it "returns true if TZInfo is available" do
      described_class.should be_usable
    end

    it "returns false if TZInfo is unavailable" do
      old_tz_info = TZInfo
      Object.send(:remove_const, :TZInfo)
      begin
        described_class.should_not be_usable
      ensure
        TZInfo = old_tz_info
      end
    end
  end
end
