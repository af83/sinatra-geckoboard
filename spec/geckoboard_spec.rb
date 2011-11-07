#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'spec_helper'
require "minitest/autorun"

describe Sinatra::Geckoboard do
  include Rack::Test::Methods

  class App < Sinatra::Base
    register Sinatra::Geckoboard

    get '/color' do
      create_color params["string"]
    end

    get '/pie' do
      pie_chart [ { "label" => "Chuck Norris",
                    "value" => 3,
                    "colour" => "#ff9900" },
                  { "label" => "Bruce Lee",
                    "value" => 0,
                    "colour" => "#ef9900" }
                ]
    end

    get '/pie2' do
      pie_chart [ { "label" => "Bruce Lee",
                    "value" => 0 }
                ]
    end

    get '/line' do
      line_chart [1, 3], ["value1", "value2"], ["top1", "top2"], "#ff9900"
    end

    get '/geck-o-meter' do
      geck_o_meter "2", {"text" => "Bruce Lee", "value" => "0"}, {"text"=> "Chuck Norris", "value" => "42"}
    end

    get '/rag' do
      rag({"text" => "Plop", "value" => 1},
          {"text" => "Plop", "value" => 4},
          {"text" => "Plop", "value" => 9})
    end
  end

  def app
    App
  end

  def assert_widget(expected_result)
    last_response.status.must_equal 200
    last_response.headers['Content-Type'].must_equal "application/json;charset=utf-8"
    last_response.body.must_equal expected_result
  end

  it "create a pie_chart" do
    get '/pie'
    assert_widget '{"item":[{"label":"Chuck Norris","value":3,"colour":"#ff9900"},{"label":"Bruce Lee","value":0,"colour":"#ef9900"}]}'
  end

  it "create a pie_chart with a default color" do
    get '/pie2'
    assert_widget '{"item":[{"label":"Bruce Lee","value":0,"colour":"#d19e63"}]}'
  end

  it "create a line chart" do
    get '/line'
    assert_widget '{"item":[1,3],"settings":{"axisx":["value1","value2"],"axisy":["top1","top2"],"colour":"#ff9900"}}'
  end

  it "create a geck-o-meter" do
    get '/geck-o-meter'
    assert_widget '{"item":"2","max":{"text":"Bruce Lee","value":"0"},"min":{"text":"Chuck Norris","value":"42"}}'
  end

  it "create a rag widget" do
    get '/rag'
    assert_widget '{"item":[{"text":"Plop","value":1},{"text":"Plop","value":4},{"text":"Plop","value":9}]}'
  end

  it "create a color in a deterministic way" do
    get '/color', "string" => "plop"
    first = last_response.body
    first.wont_be_nil
    get '/color', "string" => "plop"
    last_response.body.must_equal first
  end
end
