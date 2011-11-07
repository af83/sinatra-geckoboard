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

      # Render a geck-o-meter widget
      # Set content type as json
      # http://support.geckoboard.com/entries/274940-custom-chart-widget-type-definitions
      #
      # @param [String] values
      # @param [Hash] max Hash with text and value keys
      # @param [Hash] min Hash with text and value keys
      # @return [String] the geck-o-meter chart as json string
      def geck_o_meter(value, max, min)
        render_widget "item" => value, "max" => max, "min" => min
      end

      # Render a RAG widget
      # Set content type as json
      # http://support.geckoboard.com/entries/231507-custom-widget-type-definitions
      #
      # @param [Hash] red
      # @param [Hash] amber
      # @param [Hash] green
      # @return [String] the rag widget as json string
      def rag(red, amber, green)
        render_widget "item" => [red, amber, green]
      end

      # Render a number widget
      # Set content type as json
      # http://support.geckoboard.com/entries/231507-custom-widget-type-definitions
      #
      # @param [Hash] number1
      # @param [Hash] number2
      # @return [String] the number widget as jons string
      def number(number1, number2=nil)
        values = [number1]
        values << number2 unless number2.nil?
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
