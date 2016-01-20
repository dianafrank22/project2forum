require "bundler/setup"
require "pg"
require "sinatra/base"
require "sinatra/reloader"
require "pry"

require_relative "server"
run Forum::Server