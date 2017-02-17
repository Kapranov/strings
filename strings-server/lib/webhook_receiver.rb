#!/usr/bin/env ruby

require 'net/http/server'
require 'pp'
require 'json'
require 'byebug'

Net::HTTP::Server.run(:port => 8080) do |request,stream|
  pp request
  system './hello_world.sh'

  string = ''
  while stream.socket.ready?
    string << stream.socket.readchar
  end

  json = JSON.parse string

  # [200, {'Content-Type' => 'text/html'}, ['Hello World']]
  [200, {'Content-Type' => 'application/json'}, [{hello: 'world'}.to_json]]
end
