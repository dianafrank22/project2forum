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


conn.exec("DROP TABLE IF EXISTS users")

conn.exec("CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	username VARCHAR,
	password VARCHAR
	)"
)