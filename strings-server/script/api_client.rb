require 'faraday'
require 'oj'

client = Faraday.new(url: 'http://localhost:3000') do |config|
  config.adapter  Faraday.default_adapter
end

response = client.post do |req|
  req.url '/api/users'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "user": {"first_name": "test user"} }'
end

puts Oj.load(response.body)
puts response.status
