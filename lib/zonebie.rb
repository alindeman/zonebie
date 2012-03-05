require File.expand_path("zonebie/version", File.dirname(__FILE__))

module Zonebie
  class << self
    attr_accessor :quiet

    def backend
      unless @backend
        self.backend = :activesupport
      end

      @backend
    end

    def backend=(backend)
      case backend
      when Symbol
        @backend = @backends[backend]
      else
        @backend = backend
      end

      unless @backend
        raise ArgumentError, "Unsupported backend: #{backend}"
      end

      @backend
    end

    def add_backend(backend)
      @backends ||= {}
      @backends[backend.name] = backend
    end

    def set_random_timezone
      zones = backend.zones
      zone  = zones[rand(zones.length)]

      $stdout.puts("[Zonebie] Setting timezone to \"#{zone}\"") unless quiet
      @backend.zone = zones[rand(zones.length)]
    end
  end
end

require File.expand_path("zonebie/backends", File.dirname(__FILE__))
