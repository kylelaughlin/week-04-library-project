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

########################################
####### LIBRARY ########################
########################################
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
get '/library/:id' do
  @library = Library.find_by_id(params['id'])
  erb :library_show
end

#library edit
get '/library/:id/edit' do
  @library = Library.find_by_id(params['id'])
  erb :library_edit
end

post '/library/:id/update' do
  @library = Library.find_by_id(params['id'])
  if @library.update_attributes(branch_name: params['branch_name'],
                                address: params['address'],
                                phone_number: params['phone_number'])
    redirect to ("/library/#{@library.id}")
  else
    erb :library_edit
  end
end

########################################
####### Staff Member ###################
########################################

#libraries menu
get '/staff_members' do
  erb :staff_members_menu
end
