require "sinatra"
require "sinatra/activerecord"
require "./models"
require "bundler/setup"
require "sinatra/flash"

set :database, "sqlite3:microblog.sqlite3"
set :sessions, true


get "/" do
  @feed = Post.last(10)
  erb :homepage
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


get "/profile" do
  redirect "/profile/" + session[:user_id].to_s
end

get "/profile/:id" do
  @profile = Profile.find_by(user_id: params[:id])
  puts "yyoooooo", @profile.inspect
  @posts = User.find(params[:id]).posts
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

get "/sign_in" do
  erb :sign_in
end

post "/sign-up" do
  params.inspect
  User.create(
  username: params[:username],
  password: params[:password]
  )
  @user = User.where(username: params[:username]).first
  session[:user_id] = @user.id
  flash[:notice] = "Welcome, #{@user.username}!"
  Profile.create(
  state: params[:state],
  country: params[:country],
  user_id: session[:user_id]
  )
  redirect "/"
end

post "/create-post" do
  params.inspect
  Post.create(
  date: DateTime.now,
  content: params[:content],
  user_id: session[:user_id]
  )
  redirect "/post"
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

post "/change-account" do
  params.inspect
  @userupdate = User.find(session[:user_id])
  @userupdate.update(username: params[:username], password: params[:password])
  redirect "/edit"
end

post "/update-profile" do
  params.inspect
    Profile.update(
    state: params[:state],
    country: params[:country],
    user_id: session[:user_id]
    )
  redirect "/edit"
end
#
# def current_user
#   if session[:user_id]
#     User.find(session[:user_id])
#   end
# end
