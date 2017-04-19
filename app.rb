require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"

get "/" do
  erb :homepage
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

get "/sign_up" do
  erb :sign_up
end

post "/sign-up" do
  params.inspect
  User.create(username: params[:username], password: params[:password])
  redirect "/"
end
