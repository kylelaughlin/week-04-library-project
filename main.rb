require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

require_relative "lib/book.rb"
require_relative "lib/library.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"

Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }

#Root

get '/pry' do
  binding.pry
end

get '/' do
  erb :root
end
