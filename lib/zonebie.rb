require File.expand_path("zonebie/version", File.dirname(__FILE__))

module Zonebie
  class << self
    def backend
      unless @backend
        self.backend = :activesupport
      end

      @backend
    end

    def backend=(backend)
      case backend
      when Symbol
        @backend = @backends.detect { |b| b.name == backend }
      else
        @backend = backend
      end

      unless @backend
        raise ArgumentError, "Unsupported backend: #{backend}"
      end

      @backend
    end

    def add_backend(backend)
      @backends ||= []
      @backends << backend
    end

    def set_random_timezone
      zones = backend.zones
      zone  = zones[rand(zones.length)]

      $stdout.puts("[Zonebie] Setting timezone to \"#{zone}\"")
      @backend.zone = zones[rand(zones.length)]
    end
  end
end

require File.expand_path("zonebie/backends", File.dirname(__FILE__))
