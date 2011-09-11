module Sinatra
  module Geckoboard

    module Helpers
      # Render a line chart widget
      # Set content type as json
      # http://support.geckoboard.com/entries/274940-custom-chart-widget-type-definitions
      #
      # @param [Array] values
      # @param [Array] axisx
      # @param [Array] axisy
      # @param [String] colour
      # @return [String] the line chart as json string
      def line_chart(values=[], axisx=[], axisy=[], colour="")
        render_widget ({
          "item" => values,
          "settings" => {
            "axisx" => axisx,
            "axisy" => axisy,
            "colour" => colour
          }
        })
      end

      # Render a pie chart widget
      # Set content type as json
      # http://support.geckoboard.com/entries/274940-custom-chart-widget-type-definitions
      #
      # @param [Array] values array of hash with: value, label and colour keys
      def pie_chart(values=[])
        render_widget({
          "item" => values
        })
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
