require "spec_helper"
require "wikipedia"

describe Zonebie do
  let(:page) { mock "page" }

  before do
    Wikipedia.stubs(:find).returns page
  end

  describe ".load_from_wikipedia" do
    context "when there is info on the timezone" do
      let(:expected) {
        "Some information about a timezone"
      }

      before do
        page.stubs(:text).returns "Some information about a timezone\npara 2\n"
      end

      it "uses a new thread to request data from wikipedia and returns the first paragraph" do
        result = Zonebie.load_from_wikipedia "a timezone"
        expect(result.join.value).to eq expected
      end
    end

    context "when there is no info on the timezone" do
      let(:expected) { 
        "No information available for a timezone"
      }

      before do
        page.stubs(:text).returns nil
      end

      it "informs that there was no information" do
        result = Zonebie.load_from_wikipedia "a timezone"
        expect(result.join.value).to eq expected
      end
    end
  end

  describe ".print_timezone_info" do
    let(:out) { StringIO.new }

    context "when the request is nil" do 
      let(:message) {
        "Please set the ZONEBIE_INFO environment variable to load data from Wikipedia"
      }

      before do
        Zonebie.instance_variable_set("@request", nil)
        $stderr = out
      end

      after do
        $stderr = STDERR
      end

      it "informs the user to set the ZONEBIE_INFO variable" do
        Zonebie.print_timezone_info
        out.rewind
        expect(out.read).to eq "\n#{message}\n"
      end
    end

    context "when the request is a load error" do
      let(:message) {
        "Please install the wikipedia-client gem to download zone info"
      }

      before do
        Zonebie.instance_variable_set("@request", :load_error)
        $stderr = out
      end

      after do
        $stderr = STDERR
      end

      it "informs the user to install the wikipedia client" do
        Zonebie.print_timezone_info
        out.rewind
        expect(out.read).to eq "\n#{message}\n"
      end
    end

    context "when the request succeeds" do
      let(:t) { Thread.new { 'hello' } }

      before do
        Zonebie.instance_variable_set "@request", t
        $stdout = out
      end

      after do
        $stdout = STDOUT
      end

      it "prints the info from wikipedia" do
        Zonebie.print_timezone_info
        out.rewind
        expect(out.read).to eq "\nhello\n"
      end
    end
  end
end
