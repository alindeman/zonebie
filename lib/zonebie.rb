require "zonebie/version"
require "zonebie/backends"

module Zonebie
  class << self
    def backend
      @backend ||= Zonebie::Backends::ActiveSupport.new
      @backend.name
    end

    def backend=(backend)
      case backend
      when :activesupport
        @backend = Zonebie::Backends::ActiveSupport.new
      else
        raise ArgumentError, "Unsupported backend"
      end
    end

    def set_random_timezone
      zones = @backend.zones
      @backend.zone = zones[rand(zones.length)]
    end
  end
end
