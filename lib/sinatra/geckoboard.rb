require 'digest/md5'
require 'json'

module Sinatra
  module Geckoboard

    module Helpers
      # Create a color from string
      #
      # @param [String] string
      def create_color(string)
        "##{Digest::MD5.hexdigest(string)[0..5]}"
      end

      # Render a line chart widget
      # Set content type as json
      # http://support.geckoboard.com/entries/274940-custom-chart-widget-type-definitions
      #
      # @param [Array] values
      # @param [Array] axisx
      # @param [Array] axisy
      # @param [String] colour
      # @return [String] the line chart as json string
      def line_chart(values=[], axisx=[], axisy=[], colour="#ff9900")
        render_widget "item" => values,
                      "settings" => {
                         "axisx" => axisx,
                         "axisy" => axisy,
                         "colour" => colour
                      }
      end

      # Render a pie chart widget
      # Set content type as json
      # http://support.geckoboard.com/entries/274940-custom-chart-widget-type-definitions
      #
      # @param [Array] values array of hash with: value, label and optional colour keys
      # @return [String] the pie chart as json string
      def pie_chart(values=[])
        values.map! do |value|
          value['colour'] ||= create_color value['label']
          value
        end
        render_widget "item" => values
      end

      protected
      def render_widget(widget)
        content_type :json
        widget.to_json
      end
    end

    def self.registered(app)
      app.helpers Helpers
    end
  end
end
