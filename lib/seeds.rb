require 'pg'

# if ENV if ENV["RACK_ENV"] == 'production'
# 	conn = PG.connect(
# 		dbname: ENV["POSTGRES_DB"],
# 		host: ENV["POSTGRES_HOST"],
# 		password: ENV["POSTGRES_PASS"],
# 		user: ENV["POSTGRES_USER"]
# 		)
# else
# conn = PG.connect(dbname: "portfolio")
# end

# need to set 

# conn.exec("DROP TABLE IF EXISTS categories")

# conn.exec("CREATE TABLE categories(
#     id SERIAL PRIMARY KEY,
#     name VARCHAR(255),
#    	number_of_posts VARCHAR
#   )"
# )