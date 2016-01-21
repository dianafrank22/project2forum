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
    comments INT,
    votes INT,
    content VARCHAR,
    user_id INT REFERENCES users(id)
  )"
)


# creates table for comments
conn.exec("DROP TABLE IF EXISTS comments")

conn.exec("CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
 	content VARCHAR,
 	post_id INT REFERENCES posts(id),
 	user_id REFERENCES users(id),
 	votes INT 
  )"
)