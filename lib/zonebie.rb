require "zonebie/version"

module Zonebie
  class << self
    def backend
      unless @backend
        self.backend = :activesupport
      end

      @backend.name
    end

    def backend=(backend_name)
      if backend = @backends.detect { |b| b.name == backend_name }
        @backend = backend
      else
        raise ArgumentError, "Unsupported backend: #{backend_name}"
      end
    end

    def add_backend(backend)
      @backends ||= []
      @backends << backend
    end

    def set_random_timezone
      zones = @backend.zones
      @backend.zone = zones[rand(zones.length)]
    end
  end
end

require "zonebie/backends"
