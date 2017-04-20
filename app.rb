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
  @posts = User.find(session[:user_id]).posts
  erb :profile
  # redirect "/profile:id"
end

# get "/profile:id" do
#   @posts = User.find(session[:user_id]).posts
#   erb :profile
# end

get "/edit" do
  erb :edit
end

get "/post" do
  erb :post
end

get "/sign_up" do
  erb :sign_up
end

get "/sign_in" do
  erb :sign_in
end

post "/sign-up" do
  params.inspect
  User.create(username: params[:username], password: params[:password])
  redirect "/"
end

post "/create-post" do
  params.inspect
  Post.create(date: Date.today, content: params[:content], user_id: session[:user_id])
  redirect "/post"
end

post "/sign-in" do
  params.inspect
  @user = User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:notice] = "Welcome, #{@user.username}!"
    redirect "/"
  else
    flash[:notice] = "Your username and password do not match, please try again."
    redirect "/sign_in"
  end
end

get "/sign_out" do
  session[:user_id] = nil
  redirect "/"
end

get "/delete_account" do
  User.find(session[:user_id]).destroy
  session[:user_id] = nil
  flash[:notice] = "Your account has been deleted."
  redirect "/"
end


# def current_user
#   if session[:user_id]
#     User.find(session[:user_id])
#   end
# end
