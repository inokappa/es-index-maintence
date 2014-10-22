#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'

def config
  {
    :host => "127.0.0.1",
    :date => 7
    :prefix => "logstash"
  }
end

def delete_index_date
  d = Date.today
  d = d - config[:date]
  d.strftime("%Y.%m.%d")
end

def request_uri
  index_name = "#{config[:prefix]}-#{delete_index_date}"
  URI.parse("http://#{config[:host]}:9200/#{index_name}")
end

def get_respons(request)
  Net::HTTP.start(request_uri.host, request_uri.port) {|http|
    http.request(request)
  }
end

def check_delete_index
  request = Net::HTTP::Head.new(request_uri.path)
  get_respons request
end

def delete_index
  request = Net::HTTP::Delete.new(request_uri.path)
  get_respons request
end

if check_delete_index.code != "200"
  puts "#{config[:prefix]}-#{delete_index_date} is not subject to maintence."
else
  puts "#{config[:prefix]}-#{delete_index_date} is subject to maintence."
  delete_index
end
