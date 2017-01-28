#!/usr/bin/env ruby

require "rubygems"
require "sequel"

DB = Sequel.sqlite

DB.create_table :users do
  primary_key :id
  String :name
  Float :price
end

users = DB[:users]

users.insert(:name => 'abc', :price => rand * 100)
users.insert(:name => 'def', :price => rand * 100)
users.insert(:name => 'ghi', :price => rand * 100)

puts "User count: #{users.count}"

puts "The average price is: #{users.avg(:price)}"
