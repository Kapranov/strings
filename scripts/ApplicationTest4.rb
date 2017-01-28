#!/usr/bin/env ruby

require 'sqlite3'
require 'active_record'
require 'oj'
require 'oj_mimic_json'

# Oj.mimic_JSON()
Oj.default_options = {mode: :compat, indent: 2}

# ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => ":memory:"
)

ActiveRecord::Schema.define do
  create_table :users do |table|
    table.column :first_name, :string
    table.column :last_name, :string
    table.column :email, :string
  end
end

class User < ActiveRecord::Base
end

User.find_or_create_by(first_name: "John", last_name: "Smith", email: "john@example.com")
User.find_or_create_by(first_name: "Joan", last_name: "Smith", email: "joan@example.com")

puts "as_json - #{User.first.as_json}"
puts "to_json - #{User.first.to_json}"
puts "Oj.dump - #{Oj.dump(User.first)}"
puts "Oj.dump all - #{Oj.dump(User.all)}"
