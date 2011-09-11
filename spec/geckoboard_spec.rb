#!/usr/bin/env ruby
# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "minitest/autorun"

describe Sinatra::Geckoboard do
  include Rack::Test::Methods

  class App < Sinatra::Base
    register Sinatra::Geckoboard

    get '/pie' do
      pie_chart [ { "label" => "Chuck Norris",
                    "value" => 3,
                    "colour" => "#ff9900" },
                  { "label" => "Bruce Lee",
                    "value" => 0,
                    "colour" => "#ef9900" }
                ]
    end
  end

  def app
    App
  end

  it "create pie_chart" do
    get '/pie'
    last_response.status.must_equal 200
    last_response.body.must_equal '{"item":[{"label":"Chuck Norris","value":3,"colour":"#ff9900"},{"label":"Bruce Lee","value":0,"colour":"#ef9900"}]}'
  end
end
