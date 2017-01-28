#!/usr/bin/env ruby

gem "activerecord"
gem "sqlite3"
gem "oj", github: "ohler55/oj"

require 'active_record'
require 'oj'

Oj.mimic_JSON()
begin
  require 'json'
rescue Exception
end

ActiveRecord::Base.logger = Logger.new(STDERR)

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

User.find_or_create_by(first_name: "John", last_name: "Smith", email: "email@example.com")

puts User.first.as_json
