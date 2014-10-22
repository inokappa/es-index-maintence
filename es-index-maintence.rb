#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'date'

def config
  {
    :host => "127.0.0.1",
    :port => 9200,
    :date => 7,
    :prefix => "logstash"
  }
end

def index_date
  d = Date.today
  d = d - config[:date]
  d.strftime("%Y.%m.%d")
end

def index_name
  "#{config[:prefix]}-#{index_date}"
end

def request_uri
  URI.parse("http://#{config[:host]}:#{config[:port]}/#{index_name}")
end

def get_respons(request)
  Net::HTTP.start(request_uri.host, request_uri.port) do |http|
    http.read_timeout = 30
    http.request(request)
  end
end

def check_delete_index
  request = Net::HTTP::Head.new(request_uri.path)
  get_respons request
end

def index_delete
  request = Net::HTTP::Delete.new(request_uri.path)
  res = get_respons request
  if res.code == "200"
    puts "#{index_name} delete success."
  else
    puts "#{index_name} delete failure."
    exit 1
  end
end

if check_delete_index.code != "200"
  puts "#{index_name} is not subject to maintence."
  exit 0
else
  puts "#{index_name} is subject to maintence."
  index_delete
end
