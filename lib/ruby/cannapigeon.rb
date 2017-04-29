require "ruby/cannapigeon/version"
require 'net/http'
require 'json'

module Cannapigeon
	class Client
		def initialize(cannadove)
			@cannadove = cannadove
		end
		def cannadove_url
			"http://#{@cannadove}:3000"
		end
		def send_mail(email)
			uri = URI.parse(cannadove_url + "/dispatches/request_new")
			header = {'Content-Type' => 'application/json'}
			payload = {email: email}
			http = Net::HTTP.new(uri.host, uri.port)
			request = Net::HTTP::Post.new(uri.request_uri, header)
			request.body = payload.to_json
			response = http.request(request)
		end
	end
end

# Usage
# client = Cannapigeon::Client::new(cannadove_ip)
# email = {destinations: "email\nconsulting@mutech.solutions\n", from: "bob@sunrisepadioplace.io", subject: "Humble Awesomness 2!", template: "<h1>Sweet prince, go get em!</h1>"}
# client.send_mail(email)