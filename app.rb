require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"
set :sessions, true

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

get "/signin" do
  erb :sign_in
end

post "/sign-up" do
  params.inspect
  User.create(username: params[:username], password: params[:password])
  redirect "/"
end

post "/create-post" do
  params.inspect
  Post.create(content: params[:content])
  redirect "/post"
end

post "/sign-in" do
  params.inspect
  @user = User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    # session[:user_id] = @user.id
    redirect "/"
  else
    redirect "/post"
  end
end
