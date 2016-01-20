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

# creates table for categories

conn.exec("DROP TABLE IF EXISTS categories")

conn.exec("CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
   	number_of_posts INTEGER
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
   	category_id INTERGER REFERENCES categories(id),
   	comments INTEGER,
   	votes INTERGER,
   	content VARCHAR,
   	user_id INTERGER REFERENCES users(id)
  )"
)


# creates table for comments
conn.exec("DROP TABLE IF EXISTS comments")

conn.exec("CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
 	content VARCHAR,
 	post_id INTERGER REFERENCES posts(id),
 	user_id REFERENCES users(id),
 	votes NUM 
  )"
)