require "sinatra/base"
require "pg"
require "bcrypt"
require 'pry'

module Forum
	class Server < Sinatra::Base

    enable :sessions

    def current_user
      if session["user_id"]
        @user ||= conn.exec_params(<<-SQL, [session["user_id"]]).first
          SELECT * FROM users WHERE id = $1
        SQL
      end
    end

    # homepage
		get "/" do
      @post = conn.exec("SELECT * FROM posts")
		  erb :index
		end

    # login page
		get "/login" do
   		erb :login
  	end

     post "/login" do
        @user = conn.exec_params("SELECT * FROM users WHERE username = $1", [params["username"]]).first
        if @user
          if @user["password"] == params["password"]
            session["user_id"] = @user["id"]
            redirect "/"
          else
            erb :login
          end
        else
          erb :login
        end
      end


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
        password = params["password"]
    
         conn.exec_params(
           "INSERT INTO users(username, password) VALUES ($1, $2)",
           [username, password]
         )

        @signup_info = true
        erb :index
      end

      # new post page
      get "/new" do
        erb :newpost
      end


      post "/new" do 
        topic_name = params["topic_name"]
        content = params["content"]
        user_id = session["user_id"]

        conn.exec_params( "INSERT INTO posts(topic_name, content, user_id) VALUES ($1, $2, $3)",
        [topic_name, content, user_id]
        )

        @new_post = true
        redirect "/"
       end

      # VIEW POST PAGE
      get "/post/:id" do
        @post = conn.exec_params("SELECT * FROM posts WHERE id = #{params["id"].to_i}").first
        erb :post 
       end




  private

    def conn
      if ENV["RACK_ENV"] == 'production'
        @conn ||= PG.connect(
          dbname: ENV["POSTGRES_DB"],
          host: ENV["POSTGRES_HOST"],
          password: ENV["POSTGRES_PASS"],
          user: ENV["POSTGRES_USER"]
        )
      else
       @conn ||= PG.connect(dbname: "project2")
      end
    end
  end


end