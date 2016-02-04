module Zonebie
  module Backends
    class ActiveSupport
      class << self
        def name
          :activesupport
        end

        def zones
          ::ActiveSupport::TimeZone.all.map(&:name)
        end

        def zone=(zone)
          ::Time.zone = zone
        end

        def usable?
          defined?(::ActiveSupport)
        end
      end

      Zonebie.add_backend(self)
    end
  end
end
