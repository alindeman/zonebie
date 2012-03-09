require 'net/http'
require 'tempfile'
require 'rmagick'
require 'colorize'

module Zonebie
  module Extras
    class AsciiMap
      def initialize(zone)
        @zone  = zone
        @map   = download_map
        @ascii = map_to_ascii
      end

      def to_s
        @ascii
      end

      private

      def download_map
        request = "http://maps.googleapis.com/maps/api/staticmap?format=jpg&zoom=1&maptype=roadmap&sensor=false&center=0,0&size=500x500&markers=size:large%7Ccolor:red%7C#{URI.encode(@zone)}&style=feature:all%7Celement:labels%7Cvisibility:off&style=feature:all%7Celement:geometry%7Clightness:100&style=feature:water%7Celement:geometry%7Clightness:-100"
        uri = URI.parse(request)
        response = Net::HTTP.get_response(uri)

        image = Tempfile.new(['ascii_map', '.jpg'])
        image.write(response.body)
        image.close
        image
      end

      def map_to_ascii
        image = Magick::Image::read(@map.path).first
        image = image.scale(80, 30)
        image = image.posterize(2)

        ascii = ""
        prev_r = 0
        image.each_pixel do |pixel, c, r|
          ascii << "\n" if r != prev_r
          prev_r = r

          case pixel.to_color
          when "white" then ascii << "."
          when "red"   then ascii << ".".red
          else              ascii << " "
          end
        end

        ascii
      end
    end
  end
end