require "sinatra/base"
require "pg"
require "bcrypt"

class Server < Sinatra::Base

get "/" do
erb :index
end

get "/login" do 
erb :login
end

get "/user/:id"
params [:id]
erb :user
end

get "/new"
erb :newpost
end

get "/post/:id"
erb :post
end

get "/comment"
erb :comment
end

post "/comment" 
# redirect? 
end

get "/categories"
erb :categories

get "/category/:id"
erb :category
end 
