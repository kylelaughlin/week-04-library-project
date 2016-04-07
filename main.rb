require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

require_relative "lib/book.rb"
require_relative "lib/library.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"


#Root

get '/' do
  erb :root
end

#libraries menu
get '/libraries' do
  erb :libraries_menu
end

#libraries index
get '/libraries/index' do
  @libraries = Library.all
  erb :libraries_index
end

#library show
get 'library/show/:id' do
  @library = Library.find_by_id(params['id'])
  erb :library_show
end
