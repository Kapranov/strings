#!/usr/bin/env ruby

require 'rethinkdb'
include RethinkDB::Shortcuts

table = "people"
db = "testdb"

begin
  conn = r.connect(:host => "localhost", :port => 28015)
rescue Exception => err
  puts "Cannot connect to RethinkDB at localhost:28015"
end

begin
  r.db(db).table_create(table).run(conn)
rescue RethinkDB::RqlRuntimeError => err
  puts "Error occurred in creating #{table} table within #{db}"
  puts err
end

begin
  puts "Tables inside #{db}: ", r.db(db).table_list().run(conn)
rescue RethinkDB::RqlRuntimeError => err
  puts err
ensure
  conn.close
end
