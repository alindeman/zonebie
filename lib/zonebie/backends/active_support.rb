require "active_support/time"

module Zonebie
  module Backends
    class ActiveSupport
      def name
        :activesupport
      end

      def zones
        ::ActiveSupport::TimeZone.all.map(&:name)
      end

      def zone=(zone)
        ::Time.zone = zone
      end
    end
  end
end
