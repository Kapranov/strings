#!/usr/bin/env ruby

require 'jwt'

puts "====================== Example #1 ======================="

hmac_secret = '599ac15f824b962410dfc9748f4dabb442822d470ef62b6fbc0ba7123181daf55f579fe59fe862a4771ce211f8f79edda5b52e6458c0b35a1f15d1b2a8d28c67'
payload = {data: '4TYNfavfAgS3Ma'}

token = JWT.encode payload, hmac_secret, 'HS256'
decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }

puts "JWT Secrets: #{hmac_secret}"
puts "JWT Payload: #{payload}"
puts "JWT Encodes: #{token}"
puts "JWT Decodes: #{decoded_token}"

puts "====================== Example #2 ======================="

hmac_secret = 'iQIrdobu5FU6XMDe2QzSmfIkCk7H2ySdtQtt'
payload = {user_id: "4TYNfavfAgS3Ma", email: 'lugatex@yahoo.com', }

token = JWT.encode payload, hmac_secret, 'HS256'
decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }

puts "JWT Secrets: #{hmac_secret}"
puts "JWT Payload: #{payload}"
puts "JWT Encodes: #{token}"
puts "JWT Decodes: #{decoded_token}"

puts "====================== Example #3 ======================="

exp = Time.now.to_i - 10
leeway = 30

hmac_secret = 'iQIrdobu5FU6XMDe2QzSmfIkCk7H2ySdtQtt'
payload = { :data => 'data', :exp => exp }

token = JWT.encode payload, hmac_secret, 'HS256'

begin
  decoded_token = JWT.decode token, hmac_secret, true, { :exp_leeway => leeway, :algorithm => 'HS256' }
rescue JWT::ExpiredSignature
  # Handle expired token, e.g. logout user or deny access
end

puts "JWT Secrets: #{hmac_secret}"
puts "JWT Payload: #{payload}"
puts "JWT Encodes: #{token}"

puts "====================== Example #4 ======================="

hmac_secret = 'secret'
payload = {sub: '1234567890', name: 'John Doe', admin: true}

token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ'
decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }

puts "JWT Secrets: #{hmac_secret}"
puts "JWT Payload: #{payload}"
puts "JWT Encodes: #{token}"
puts "JWT Decodes: #{decoded_token}"

puts "====================== Example #5 ======================="

payload = JWT.encode({
  :email => "bob@example.com", :name => "Bob", :iat => Time.now.to_i, :jti => rand(2<<64).to_s
}, "Our shared secret")

puts "JWT Payload: #{payload}"
puts "response.headers\[\"Location\"\] = \"https\:\/\/example.test.com\/access\/jwt?jwt\=\#\{payload\}\""

puts "========================================================="
