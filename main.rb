require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file}

set :views, Proc.new { File.join(root, "app/views")}

get '/pry' do
  binding.pry
end

get '/' do
  erb :root
end
