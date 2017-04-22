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
    redirect "/"
  end
end


get "/profile" do
  redirect "/profile/" + session[:user_id].to_s
end

get "/profile/:id" do
  @profile = Profile.find_by(user_id: params[:id])
  @posts = User.find(params[:id]).posts
  erb :profile
end

get "/edit" do
  erb :edit
end

get "/post" do
  @profile = User.find(session[:user_id]).profile
  @posts = User.find(session[:user_id]).posts
  erb :post
end

get "/sign_up" do
  erb :sign_up
end

post "/sign-up" do
  params.inspect
  if User.find_by(username:params[:username])
      flash[:notice] = "That username already exists please choose a different username"
      redirect "/sign_up"
    else
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
end

post "/create-post" do
  params.inspect
  @posttime = DateTime.now.strftime"%m/%d/%Y %H:%M"
  Post.create(
  date: @posttime,
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
  @existinguser = User.find_by(username:params[:username])
  if @existinguser != @userupdate
    flash[:notice] = "That username already exists please choose a different username"
    redirect "/edit"
  else
    @userupdate.update(
    username: params[:username],
    password: params[:password]
    )
    redirect "/edit"
  end
end

post "/update-profile" do
  params.inspect
    @profileupdate = Profile.find_by(user_id: session[:user_id])
    @profileupdate.update(
    state: params[:state],
    country: params[:country],
    user_id: session[:user_id]
    )
  redirect "/edit"
end

get "/delete-post/:id" do
  Post.find(params[:id]).destroy
  redirect "/post"
end

post "/edit-post/:id" do
  @posttime = DateTime.now.strftime"%m/%d/%Y %H:%M"
  Post.find(params[:id]).update(
  date: @posttime,
  content: params[:content],
  user_id: session[:user_id]
  )
  redirect "/post"
end

get "/edituserpost/:id" do
  @editpost = Post.find(params[:id])
  erb :edituserpost
end
