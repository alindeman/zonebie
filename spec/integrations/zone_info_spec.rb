require "spec_helper"
require "zonebie/zone_info"
require 'wikipedia'

describe "#print_timezone_info" do
  let(:content) { "some wiki info\nsecond paragraph" }
  let(:expected) { "\nsome wiki info\n" }
  let(:page) { mock 'page' }
  let(:out) { StringIO.new }

  before do
    $stdout.stubs(:puts)
    Wikipedia.stubs(:find).returns(page)
    page.stubs(:text).returns content
    ENV["ZONEBIE_INFO"] = "true"
    Zonebie.set_random_timezone
    $stdout = out
  end
  
  after do
    $stdout = STDOUT
  end

  it "prints info about the time zone to stdout" do
    Zonebie.print_timezone_info
    out.rewind
    expect(out.read).to eq expected
  end
end
