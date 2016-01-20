module Forum
	class Server < Sinatra::Base

# homepage
		get "/" do
		erb :index
		end

# login page
		# get "/login" do 
		# erb :login
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
