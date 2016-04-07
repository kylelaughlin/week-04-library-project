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

get '/library/new' do
  @library = Library.new
  erb :library_new
end

post '/libraries' do
  binding.pry
  @library = Library.new(params)
  if @library.save
    redirect to("/libraries")
  else
    erb :library_new
  end
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

# staff member menu
get '/staff_members' do
  erb :staff_members_menu
end

#staff member index
get '/staff_members/index' do
  @staff_members = StaffMember.all
  erb :staff_member_index
end

# staff member show
get '/staff_member/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  erb :staff_member_show
end
