require File.expand_path("zonebie/version", File.dirname(__FILE__))

module Zonebie
  class << self
    attr_accessor :quiet

    def backend
      unless @backend
        @backend = @backends.values.detect(&:usable?)
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

      if !backend.nil? && @backend.nil?
        raise ArgumentError, "Unsupported backend: #{backend}"
      end

      @backend
    end

    def add_backend(backend)
      @backends ||= {}
      @backends[backend.name] = backend
    end

    def set_random_timezone
      zone = random_timezone

      $stdout.puts("[Zonebie] Setting timezone to \"#{zone}\"") unless quiet
      @backend.zone = zone
    end

    def random_timezone
      zones = backend.zones
      zones[rand(zones.length)]
    end
  end
end

require File.expand_path("zonebie/backends", File.dirname(__FILE__))
