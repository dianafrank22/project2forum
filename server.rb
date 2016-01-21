require "sinatra/base"
require "pg"
require "bcrypt"

module Forum
	class Server < Sinatra::Base

 
# homepage
		get "/" do
		erb :index
		end

# login page
		get "/login" do
   			erb :login
  		end

  		post "/login" do 
  			redirect('/')
      end

# signup page brings up form
  		get "/signup" do 
  			erb :signup
  		end

# sends form data to data base and creates a new user
# try and encrypt password with bcrypt later! 
  		post "/signup" do 
      username = params["username"]
      password = params["password"]
    
  
        if ENV["RACK_ENV"] == 'production'
          conn = PG.connect(
          dbname: ENV["POSTGRES_DB"],
          host: ENV["POSTGRES_HOST"],
          password: ENV["POSTGRES_PASS"],
          user: ENV["POSTGRES_USER"]
          )
        else
         conn = PG.connect(dbname: "project2")
        end

      conn.exec_params( "INSERT INTO users(username, password) VALUES ($1, $2)",
      [username, password]
      )

      @signup_info = true
      erb :index
    end



# new post page
      get "/new" do
      	erb :newpost
      end



# view a list of categories
		get "/categories" do
      @categories = db.exec("SELECT * FROM categories")
		erb :categories
		end

# view a list of posts in that category
		get "/category/:id" do
      @category = db.exec("SELECT topic_name FROM posts WHERE category_id = #{params["id"].to_i}").first
		erb :category
		end 



    def db
      PG.connect(dbname: "project2")
    end

	end
end
