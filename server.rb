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

# signup page
  		get "/signup" do 
  			erb :signup
  		end

  		post "/signup" do 
        encrypted_password = BCrypt::Password.create([:password])
        
      users = @@db.exec_params(<<-SQL, [params[:username],encrypted_password]) 
      INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id;
      SQL
      end


# user page
		# get "/user/:id"
		# params [:id]
		# erb :user
		# end

# new post page
      get "/new" do
      	erb :newpost
      end

      # post "/new" do

      #   redirects('/post/:id')
      # end

# viewing the post
	   # 	get "/post/:id" do
    #     @id = db.exec_params("SELECT * FROM posts WHERE id = #{params["id"].to_i}").first
	   #   	erb :post
		  # end

# # adding a comment
    #  get "/comment" do
      # erb :comment
    # end

	   # post "/comment" do
       # redirect? 
    # end

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
