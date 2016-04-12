require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file}
#Root

get '/pry' do
  binding.pry
end

get '/' do
  erb :root
end
