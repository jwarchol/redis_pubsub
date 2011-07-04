#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'goliath'

class RedisPubsub < Goliath::API
	use Goliath::Rack::Params
	use Goliath::Rack::Render, 'json'

	def response(env)
		data = nil
		req_fiber = Fiber.current
		channel.pop do |msg|
			data = msg
			req_fiber.resume
		end
		Fiber.yield
		
		[200, {}, [data]]
	end
end
