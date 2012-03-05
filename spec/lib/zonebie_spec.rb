require "spec_helper"

describe Zonebie do
  describe "#backend" do
    it "defaults to the activesupport backend in the presence of activesupport" do
      Zonebie.backend.should == :activesupport
    end

    pending "allows setting the backend to tzinfo"

    pending "defaults to tzinfo in the absense ot activesupport"

    it "does not allow setting the backend to an unsupported value" do
      expect {
        Zonebie.backend = :foobar
      }.to raise_error(ArgumentError)
    end
  end
end
