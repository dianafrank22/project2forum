require "pg"

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



# table for categories
conn.exec("DROP TABLE IF EXISTS categories")

conn.exec("CREATE TABLE categories(
	id SERIAL PRIMARY KEY,
	category_name VARCHAR 
	)"
)

# creates user table
conn.exec("DROP TABLE IF EXISTS users")

conn.exec("CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR,
	password VARCHAR
	)"
)



# creates table for posts

conn.exec("DROP TABLE IF EXISTS posts")

conn.exec("CREATE TABLE posts(
    id SERIAL PRIMARY KEY,
    topic_name VARCHAR(255),
    votes INT DEFAULT 0,
    content VARCHAR,
    user_id INT REFERENCES users(id) NOT NULL,
    num_comments INT DEFAULT 0,
    cat_id INT REFERENCES categories(id) NOT NULL
  )"
)


# creates table for comments
conn.exec("DROP TABLE IF EXISTS comments")

conn.exec("CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
 	content VARCHAR,
 	post_id INT REFERENCES posts(id) NOT NULL,
 	user_id INT REFERENCES users(id) NOT NULL,
 	votes INT DEFAULT 0
  )"
)


