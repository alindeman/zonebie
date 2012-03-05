require "spec_helper"

describe Zonebie::Backends::ActiveSupport do
  describe "#name" do
    its(:name) { should == :activesupport }
  end

  describe "#zones" do
    it "returns a list of zones provided by ActiveSupport" do
      ::ActiveSupport::TimeZone.stubs(:all).
        returns([
          stub(:name => "Eastern Time (US & Canada)"),
          stub(:name => "Central Time (US & Canada)")
        ])

      subject.zones.should =~ ["Eastern Time (US & Canada)", "Central Time (US & Canada)"]
    end
  end

  describe "#zone=" do
    it "sets Time.zone provided by ActiveSupport" do
      ::Time.expects(:zone=).with("Eastern Time (US & Canada)")

      subject.zone = "Eastern Time (US & Canada)"
    end
  end
end
