#!/usr/bin/env ruby

require 'rubygems'
require 'eventmachine'

module EchoServer  
  def receive_data(data)
    puts data
  end
end

EventMachine::run do
  host = '0.0.0.0'
  port = 8080
  EventMachine::start_server host, port, EchoServer
  puts "Started EchoServer on #{host}:#{port}..."
end