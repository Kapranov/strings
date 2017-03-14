#!/usr/bin/env bash

curl -s https://www.iana.org/assignments/http-status-codes/http-status-codes-1.csv | \
  ruby -ne 'm = /^(\d{3}),(?!Unassigned|\(Unused\))([^,]+)/.match($_) and \
  puts "#{m[1]} => \x27#{m[2].strip}\x27,"'
