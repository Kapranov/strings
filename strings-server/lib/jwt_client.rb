#!/usr/bin/env ruby

require 'jwt'

puts "====================== Example #2 ======================="
hmac_secret = '599ac15f824b962410dfc9748f4dabb442822d470ef62b6fbc0ba7123181daf55f579fe59fe862a4771ce211f8f79edda5b52e6458c0b35a1f15d1b2a8d28c67'
puts "JWT Secrets: #{hmac_secret}"

payload = {data: '4TYNfavfAgS3Ma'}
puts "JWT Payload: #{payload}"

token = JWT.encode payload, hmac_secret, 'HS256'
puts "JWT Encodes: #{token}"

decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
puts "JWT Decodes: #{decoded_token}"
puts "====================== Example #2 ======================="
hmac = 'iQIrdobu5FU6XMDe2QzSmfIkCk7H2ySdtQtt'
puts "JWT Secrets: #{hmac}"
payload = {user_id: "4TYNfavfAgS3Ma", email: 'lugatex@yahoo.com', }
puts "JWT Payload: #{payload}"

token = JWT.encode payload, hmac, 'HS256'
puts "JWT Encodes: #{token}"

decoded_token = JWT.decode token, hmac, true, { :algorithm => 'HS256' }
puts "JWT Decodes: #{decoded_token}"
puts "====================== Example #3 ======================="
hmac = 'iQIrdobu5FU6XMDe2QzSmfIkCk7H2ySdtQtt'
puts "JWT Secrets: #{hmac}"

exp = Time.now.to_i - 10
leeway = 30

exp_payload = { :data => 'data', :exp => exp }
puts "JWT Payload: #{exp_payload}"

token = JWT.encode exp_payload, hmac, 'HS256'
puts "JWT Encodes: #{token}"

begin
  decoded_token = JWT.decode token, hmac, true, { :exp_leeway => leeway, :algorithm => 'HS256' }
rescue JWT::ExpiredSignature
  # Handle expired token, e.g. logout user or deny access
end
puts "====================== Example #4 ======================="
payload = JWT.encode({
  :email => "bob@example.com", :name => "Bob", :iat => Time.now.to_i, :jti => rand(2<<64).to_s
}, "Our shared secret")
puts "JWT Payload: #{payload}"
puts "response.headers\[\"Location\"\] = \"https\:\/\/example.test.com\/access\/jwt?jwt\=\#\{payload\}\""
puts "========================================================="
