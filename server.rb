module Forum
	class Server < Sinatra::Base

 	# @@db = PG.connect(dbname: "project2")
# homepage
		get "/" do
		erb :index
		end

# login page
		get '/login' do
   		erb :login
  		end


	# get "/signup" do 
	# 	erb :signup
	# end

	# post "/signup" do 
	# 	encrypted_password = BCrypt::Password.create(params[:login_password])
	# 	users = @@db.exec_params(<<-SQL, [params[:login_name],encrypted_password]) 
 #      INSERT INTO users (login_name, login_password_digest) VALUES ($1, $2) RETURNING id;
 #      SQL

	# 	session["user_id"] = users.first["id"]
	#   erb :signup_success
	# end





		# get "/user/:id"
		# params [:id]
		# erb :user
		# end
# new post
# 		get "/new"
# 		erb :newpost
# 		end

# # viewing the post
# 		get "/post/:id"
# 		erb :post
# 		end

# # adding a comment
# 		get "/comment"
# 		erb :comment
# 		end

# 		# post "/comment" 
# 		# # redirect? 
# 		# end

# # view a list of categories
# 		get "/categories"
# 		erb :categories
# 		end

# # view a list of posts in that category
# 		get "/category/:id"
# 		erb :category
# 		end 


	end
end
