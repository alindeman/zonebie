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
end
