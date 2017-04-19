require "sinatra"

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
