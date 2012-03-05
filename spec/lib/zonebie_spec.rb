require "spec_helper"

describe Zonebie do
  describe "#backend" do
    it "defaults to the activesupport backend in the presence of activesupport" do
      Zonebie.backend.name.should == :activesupport
    end

    pending "allows setting the backend to tzinfo"

    pending "defaults to tzinfo in the absense ot activesupport"

    it "does not allow setting the backend to an unsupported value" do
      expect {
        Zonebie.backend = :foobar
      }.to raise_error(ArgumentError)
    end
  end

  describe "#add_backend" do
    it "allows registration of backends classes" do
      expect {
        Zonebie.backend = :my_new_backend
      }.to raise_error(ArgumentError)

      Zonebie.add_backend(stub(:name => :my_new_backend))
      Zonebie.backend = :my_new_backend
    end
  end
end
