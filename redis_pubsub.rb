#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'goliath'

class RedisPubsub < Goliath::API
	use(Rack::Static, :root => Goliath::Application.app_path("public"), :urls => ["/index.html", "/favicon.ico", '/stylesheets/', '/javascripts/', '/images/'])
	use Goliath::Rack::Params
	use Goliath::Rack::Render, 'json'


	def response(env)
		if env['PATH_INFO'] == "/" 
			[301, {'Location' => '/index.html'}, nil]
		else
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
end
