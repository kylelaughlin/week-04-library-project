require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

require_relative "lib/book.rb"
require_relative "lib/library.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"

binding.pry

#Root

get '/' do
  erb :root
end

#library menu
get '/libraries' do
  erb :libraries_menu
end

#library index
get '/libraries/index' do
  @libraries = Library.all
  erb :libraries_index
end
