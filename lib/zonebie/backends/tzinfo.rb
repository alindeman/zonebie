module Zonebie
  module Backends
    class TZInfo
      class << self
        def name
          :tzinfo
        end

        def zones
          ::TZInfo::Timezone.all.map(&:identifier)
        end

        def zone=(_zone)
          $stderr.puts('[Zonebie] It is not possible to set a global timezone with `tzinfo`')
        end

        def usable?
          defined?(::TZInfo)
        end
      end

      Zonebie.add_backend(self)
    end
  end
end
