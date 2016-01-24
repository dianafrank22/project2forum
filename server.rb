require "sinatra/base"
require "pg"
require "bcrypt"
require 'pry'
require 'redcarpet'

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

    def use_markdown(item)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, underline: true, prettify: true)
      markdown.render(item)
    end


 # login page
    get "/login" do
      erb :login
    end

     post "/login" do
        @user = conn.exec_params("SELECT * FROM users WHERE username = $1", [params["username"]]).first
       if @user
          if BCrypt::Password.new(@user["password"]) == params["password"]
            session["user_id"] = @user["id"]
            redirect "/"
          else
            @error = "Invalid Password"
            erb :login
          end
        else
          @error = "Invalid Username"
          erb :login
        end
      end


      # log out 

      get "/logout" do
        @user = current_user
        session.clear
        redirect "/"
      end
      

      # signup page brings up form
      get "/signup" do 
        erb :signup
      end

      # sends form data to data base and creates a new user
      # try and encrypt password with bcrypt later! 
      post "/signup" do 
        username = params["username"]
        encrypt_password = BCrypt::Password.create(params["password"])
        conn.exec_params(
           "INSERT INTO users(username, password) VALUES ($1, $2)",
           [username, encrypt_password]
         )

        redirect "/"
      end

     

     

      get "/" do
      # PSQL specifying specific columns because it was confusing posts.id with users.id
      # add category table selectory in here
        @categories = conn.exec("SELECT * FROM categories")
        erb :index
      end

      

      # creates new category
       get "/new_cat" do 
       if current_user
           erb :newcategory
         else
          @error = "Please Log In Before Creating New Category"
          erb :login
        end
      end

       post "/new_cat" do 
        category_name = use_markdown(params["category_name"])
        conn.exec_params( "INSERT INTO categories(category_name) VALUES ($1)",
        [category_name]
        )

        @new_category = true
        redirect '/'
       end


 
   
    # shows posts in category by votes
      get "/:id" do 
        @posts = conn.exec("SELECT * FROM posts WHERE posts.cat_id = #{params["id"]} ORDER BY VOTES DESC")
        @category = conn.exec_params("SELECT * FROM categories WHERE id = #{params["id"].to_i}").first
        erb :category
      end

    # sorting category page by number of comments 
    get "/:id/bycomments" do
      @category = conn.exec_params("SELECT * FROM categories WHERE id = #{params["id"].to_i}").first
      @posts = conn.exec("SELECT * FROM posts WHERE posts.cat_id = #{params["id"]} ORDER BY num_comments DESC")
      erb :bycomments
    end

 
 

          # new post page
      get "/:id/new" do
        @category = conn.exec_params("SELECT * FROM categories WHERE id = #{params["id"].to_i}").first
        if current_user
           erb :newpost
         else
          @error = "Please Log In Before Posting"
          erb :login
        end
      end


      post "/:id/new" do 
        topic_name = use_markdown(params["topic_name"])
        content = use_markdown(params["content"])
        user_id = session["user_id"]
        cat_id = params["id"].to_i

        conn.exec_params( "INSERT INTO posts(topic_name, content, user_id, cat_id) VALUES ($1, $2, $3, $4)",
        [topic_name, content, user_id, cat_id]
        )

        @new_post = true
        redirect back
       end



       # view post page
      get "/post/:id" do
        @post = conn.exec("SELECT * FROM posts WHERE id = #{params["id"].to_i}").first
        @comments = conn.exec_params("SELECT * FROM comments WHERE post_id = #{params["id"].to_i}")
        erb :post
      end



       # create new comment
       get "/:id/comment" do
         @post = conn.exec_params("SELECT * FROM posts WHERE id = #{params["id"].to_i}").first
          if @current_user == true
             erb :comment
          else
            @error = "Please Log In Before Commenting"
            erb :login
          end
        erb :comment
       end

      # post new comment 
      post "/:id/comment" do
        if current_user
          content = params["content"]
          post_id = params["id"].to_i
          user_id = session["user_id"]
          conn.exec_params( "INSERT INTO comments(content, post_id, user_id) VALUES ($1, $2, $3)",
          [content, post_id, user_id]
          )

          @new_comment = true
           conn.exec_params("UPDATE posts SET num_comments = num_comments + 1 WHERE id = #{params["id"].to_i}")
           redirect back
          
        else
          redirect "/"
        end
      end

      # changing votes
      get "/:id/vote/up" do 
        conn.exec_params( "UPDATE posts SET votes = votes + 1 WHERE id = #{params["id"].to_i}")
       redirect back 
      end

      get "/:id/vote/down" do
        conn.exec_params( "UPDATE posts SET votes = votes - 1 WHERE id = #{params["id"].to_i}")
      redirect back  
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