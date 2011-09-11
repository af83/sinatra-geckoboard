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

    get '/line' do
      line_chart [1, 3], ["value1", "value2"], ["top1", "top2"], "#ff9900"
    end
  end

  def app
    App
  end

  it "create apie_chart" do
    get '/pie'
    last_response.status.must_equal 200
    last_response.body.must_equal '{"item":[{"label":"Chuck Norris","value":3,"colour":"#ff9900"},{"label":"Bruce Lee","value":0,"colour":"#ef9900"}]}'
  end

  it "create a line chart" do
    get '/line'
    last_response.status.must_equal 200
    last_response.body.must_equal '{"item":[1,3],"settings":{"axisx":["value1","value2"],"axisy":["top1","top2"],"colour":"#ff9900"}}'
  end
end
