require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require
require 'user'

# DataMapper.setup(:default, 'sqlite::memory')
DataMapper.setup :default, "sqlite://#{Dir.pwd}/database.db"
DataMapper.finalize
# DataMapper.auto_migrate!
DataMapper.auto_upgrade!

get '/' do
  "Hello Users!"
end

get '/users' do
  content_type :json

  users = User.all
  users.to_json
end

get '/users/:id' do
  content_type :json

  users = User.get params[:id]
  users.to_json
end

post '/users' do
  content_type :json

  user = User.new params[:user]

  if user.save
    status 201
    json "User was created."
  else
    status 500
    json user.errors.full_messages
  end
end

put '/users/:id' do
  content_type :json

  user = User.get params[:id]

  if user.update params[:user]
    status 201
    json "User was updated."
  else
    status 500
    json user.errors.full_messages
  end
end

delete '/users/:id' do
  content_type :json

  user = User.get params[:id]
  if user.destroy
    status 201
    json "User was removed."
  else
    status 500
    json "User There as a problem removing the user."
  end
end
