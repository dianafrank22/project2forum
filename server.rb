require "sinatra/base"
require "pg"
require "bcrypt"

module Forum
	class Server < Sinatra::Base
    enable :sessions



# checks to see if user is logged in
      # def current_user 
      #   if session["user_id"]
      #     @user ||= @@db.exec_params(<<-SQL, [session["user_id"]]).first
      #       SELECT * FROM users WHERE id= $1
      #     SQL
      #   else
      #     {}
      #   end
      # end

 
# homepage
		get "/" do
		  erb :index
		end

# login page
		# get "/login" do
  #  			erb :login
  # 		end

  # 	post "/login" do 
  #      @user = @@db.exec_params("SELECT * FROM users WHERE username = $1", [params[:username]]).first
  #        if @user 
  #           if @user["password"] = params[:password]
  #             redirect "/"
  #           else
  #             erb :login
  #           end
  #         else
  #           erb :login
  #         end
  #     end


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

         conn.exec_params( "INSERT INTO users(username, encrypted_password) VALUES ($1, $2)",
         [username, password]
        )

        @signup_info = true
        erb :index
      end



# new post page
      # get "/new" do
      # 	erb :newpost
      # end


      # post "/new" do 
      #   topic_name = params["topic_name"]
      #   content = params["content"]
      #   session["user_id"] = params["user_id"]



      #  if ENV["RACK_ENV"] == 'production'
      #     conn = PG.connect(
      #     dbname: ENV["POSTGRES_DB"],
      #     host: ENV["POSTGRES_HOST"],
      #     password: ENV["POSTGRES_PASS"],
      #     user: ENV["POSTGRES_USER"]
      #     )
      #   else
      #    conn = PG.connect(dbname: "project2")
      #   end

      #   conn.exec_params( "INSERT INTO posts(topic_name, content, user_id) VALUES ($1, $2, $3)",
      #   [topic_name, content, user_id]
      #   )

      #     # insert into statement user id from session 

      #   @new_post = true
      #   erb :post
      #  end



    def db
      PG.connect(dbname: "project2")
    end

	
end
end