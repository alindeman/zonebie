module Zonebie
  class << self
    def load_from_wikipedia(zone)
      require 'wikipedia'
      @request = Thread.new {
        text = Wikipedia.find(zone).text
        if text
          text.split("\n").first
        else
          "No infomration available for #{zone}"
        end
      }
    rescue LoadError
      @request = :load_error
    end

    def print_timezone_info
      case @request
      when nil
        $stderr.puts 'Please set the ZONEBIE_INFO environment variable to load data from Wikipedia'
      when :load_error
        $stderr.puts 'Please install the wikipedia-client gem to download zone info'
      else 
        $stdout.puts "", @request.join.value
      end
    end
  end
end
