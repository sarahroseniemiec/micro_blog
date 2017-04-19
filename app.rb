require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"

get "/" do
  "hello world"
end

get "/profile" do
  erb :profile
end

get "/edit" do
  erb :edit
end

get "/post" do
  erb :post
end

get "/feed" do
  erb :feed
end
