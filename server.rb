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

  	# post "/login" do 
   #   erb :index
   #    end


      # compare given information to database
      # if true session user_id = id 
      # enable sessions
      

# signup page brings up form
  		get "/signup" do 
  			erb :signup
  		end

# sends form data to data base and creates a new user
# try and encrypt password with bcrypt later! 
  		post "/signup" do 
        username = params["username"]
        encrypted_password = BCrypt::Password.create(params[:password])
    
  
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
         [username, encyrpted_password]
        )

        @signup_info = true
        erb :index
      end






    def db
      PG.connect(dbname: "project2")
    end

	
end
end