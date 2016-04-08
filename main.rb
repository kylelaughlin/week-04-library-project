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

#staff member new
get '/staff_member/new' do
  @staff_member = StaffMember.new
  @libraries = Library.all
  erb :staff_member_new
end

post '/staff_members' do
  @staff_member = StaffMember.new(params)
  if @staff_member.save
    redirect to("/staff_members")
  else
    erb :staff_member_new
  end
end

# staff member show
get '/staff_member/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library_name = @staff_member.library.branch_name
  erb :staff_member_show
end

# staff member edit
get '/staff_member/:id/edit' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @libraries = Library.all
  erb :staff_member_edit
end

post '/staff_member/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @staff_member.update_attributes(name: params['name'],email: params['email'], library: @library)
    redirect to ("/staff_member/#{@staff_member.id}")
  else
    erb :staff_member_edit
  end
end

########################################
####### Books ##########################
########################################

# books menu
get '/books' do
  erb :books_menu
end

get '/books/index' do
  @books = Book.all
  erb :books_index
end

get '/book/new' do
  @book = Book.new
  @libraries = Library.all
  erb :book_new
end

post '/books' do
  @book = Book.new(params)
  if @book.save
    redirect to("/books")
  else
    erb :book_new
  end
end

get '/book/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(@book.library_id)
  erb :book_show
end

get '/book/:id/edit' do
  @book = Book.find_by_id(params['id'])
  @libraries = Library.all
  erb :book_edit
end

post '/book/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @book.update_attributes(title: params['title'], author: params['author'],
                              isbn: params['isbn'], library: @library)
    redirect to ("/book/#{@book.id}")
  else
    erb :book_edit
  end
end

get '/book/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patrons = Patron.all
  erb :book_checkout
end

post '/book/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patron = Patron.find_by_id(params['patron_id'])
  if @book.update_attributes(patron: @patron)
    redirect to("/book/#{@book.id}")
  else
    erb :book_checkout
  end
end

get '/book/:id/checkin' do
  @book = Book.find_by_id(params['id'])
  if @book.update_attributes(patron_id: nil)
    redirect to("/book/#{@book.id}")
  else
    erb :book_show
  end
end

########################################
####### Patron #########################
########################################

# patrons menu
get '/patrons' do
  erb :patrons_menu
end

get '/patrons/index' do
  @patrons = Patron.all
  erb :patrons_index
end

get '/patron/:id' do
  @patron = Patron.find_by_id(params['id'])
  erb :patron_show
end
