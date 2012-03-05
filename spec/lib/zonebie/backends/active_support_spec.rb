require "spec_helper"

describe Zonebie::Backends::ActiveSupport do
  describe "#name" do
    it "is :activesupport" do
      described_class.name.should == :activesupport
    end
  end

  describe "#zones" do
    it "returns a list of zones provided by ActiveSupport" do
      ::ActiveSupport::TimeZone.stubs(:all).
        returns([
          stub(:name => "Eastern Time (US & Canada)"),
          stub(:name => "Central Time (US & Canada)")
        ])

      described_class.zones.should =~ ["Eastern Time (US & Canada)", "Central Time (US & Canada)"]
    end
  end

  describe "#zone=" do
    it "sets Time.zone provided by ActiveSupport" do
      ::Time.expects(:zone=).with("Eastern Time (US & Canada)")

      described_class.zone = "Eastern Time (US & Canada)"
    end
  end
end
