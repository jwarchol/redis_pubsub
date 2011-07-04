#!/usr/bin/env ruby
# Ping something and send the output to redis
require 'rubygems'
require 'eventmachine'
require 'em-hiredis'

redis = nil

module PingToRedis
  def initialize(redis)
    @redis = redis
  end
  def post_init
    puts "post_init"
  end
  def receive_data(data)
    @redis.publish("ping", data)
    puts data
  end
  def unbind
    puts "unbind"
  end
end
EM.run do
  redis = EM::Hiredis.connect
  EM.popen("ping -i 5 209.87.79.232", PingToRedis, redis)	
end
