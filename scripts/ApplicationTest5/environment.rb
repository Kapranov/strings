# encoding=utf-8
require 'logger'
require 'rubygems'
require 'bundler/setup'
require 'active_record'

APP_DIR = File.expand_path File.dirname(__FILE__)

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3',
  pool: 5,
  timeout: 5000
)
