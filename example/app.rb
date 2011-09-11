$:.unshift File.expand_path('../../lib', __FILE__)

require 'sinatra/base'
require 'sinatra/geckoboard'

class App < Sinatra::Base
  register Sinatra::Geckoboard

  get '/pie_graph' do
    pie_chart [ { "label" => "Chuck Norris",
                  "value" => 3,
                  "colour" => "#ff9900" },
                { "label" => "Bruce Lee",
                  "value" => 0,
                  "colour" => "#ef9900" }
              ]
  end

  get '/line_chart' do
    line_chart [1, 3], ["value1", "value2"], ["top1", "top2"], "#ff9900"
  end
end

if __FILE__ == $0
  App.run!
end
