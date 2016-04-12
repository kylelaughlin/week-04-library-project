require "pry"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/reloader"

require_relative "lib/book.rb"
require_relative "lib/library.rb"
require_relative "lib/patron.rb"
require_relative "lib/staff_member.rb"


#Root

get '/pry' do
  binding.pry
end

get '/' do
  erb :root
end

########################################
####### LIBRARY ########################
########################################

#libraries index
get '/libraries' do
  @libraries = Library.all
  erb :libraries_index
end

get '/libraries/new' do
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
get '/libraries/:id' do
  @library = Library.find_by_id(params['id'])
  @staff_members = StaffMember.where(library_id: params['id'])
  @books = Book.where(library_id: params['id'])
  erb :library_show
end

#library edit
get '/libraries/:id/edit' do
  @library = Library.find_by_id(params['id'])
  erb :library_edit
end

post '/libraries/:id' do
  binding.pry
  @library = Library.find_by_id(params['id'])
  if @library.update_attributes(branch_name: params['branch_name'],
                                address: params['address'],
                                phone_number: params['phone_number'])
    redirect to ("/libraries/#{@library.id}")
  else
    erb :library_edit
  end
end

get '/libraries/:id/staff_members' do
  @library = Library.find_by_id(params['id'])
  @staff_members = StaffMember.where(library_id: params['id'])
  erb :library_staff_members
end

########################################
####### Staff Member ###################
########################################

#staff member index
get '/staff_members' do
  @staff_members = StaffMember.all
  erb :staff_member_index
end

#staff member new
get '/staff_members/new' do
  @staff_member = StaffMember.new
  @libraries = Library.all
  erb :staff_member_new
end

post '/staff_members' do
  @staff_member = StaffMember.new(params)
  @libraries = Library.all
  if @staff_member.save
    redirect to("/staff_members")
  else
    erb :staff_member_new
  end
end

# staff member show
get '/staff_members/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library_name = @staff_member.library.branch_name
  erb :staff_member_show
end

# staff member edit
get '/staff_members/:id/edit' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @libraries = Library.all
  erb :staff_member_edit
end

post '/staff_members/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @staff_member.update_attributes(name: params['name'],email: params['email'], library: @library)
    redirect to ("/staff_members/#{@staff_member.id}")
  else
    @libraries = Library.all
    erb :staff_member_edit
  end
end

########################################
####### Books ##########################
########################################

get '/books' do
  @books = Book.all
  erb :books_index
end

get '/books/new' do
  @book = Book.new
  @libraries = Library.all
  erb :books_new
end

post '/books' do
  @book = Book.new(params)
  @libraries = Library.all
  if @book.save
    redirect to("/books")
  else
    erb :books_new
  end
end

get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(@book.library_id)
  erb :books_show
end

get '/books/:id/edit' do
  @book = Book.find_by_id(params['id'])
  @libraries = Library.all
  erb :books_edit
end

post '/books/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @book.update_attributes(title: params['title'], author: params['author'],
                              isbn: params['isbn'], library: @library)
    redirect to ("/books/#{@book.id}")
  else
    erb :books_edit
  end
end

get '/books/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patrons = Patron.all
  erb :books_checkout
end

post '/books/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patron = Patron.find_by_id(params['patron_id'])
  if @book.update_attributes(patron: @patron)
    redirect to("/books/#{@book.id}")
  else
    erb :books_checkout
  end
end

get '/books/:id/checkin' do
  @book = Book.find_by_id(params['id'])
  if @book.update_attributes(patron_id: nil)
    redirect to("/books/#{@book.id}")
  else
    erb :books_show
  end
end

########################################
####### Patron #########################
########################################

get '/patrons' do
  @patrons = Patron.all
  erb :patrons_index
end

get '/patrons/new' do
  @patron = Patron.new
  erb :patron_new
end

post '/patrons' do
  @patron = Patron.new(params)
  if @patron.save
    redirect to("/patrons")
  else
    erb :patron_new
  end
end

get '/patrons/:id' do
  @patron = Patron.find_by_id(params['id'])
  erb :patron_show
end

get '/patrons/:id/edit' do
  @patron = Patron.find_by_id(params['id'])
  erb :patron_edit
end

post '/patrons/:id' do
  @patron = Patron.find_by_id(params['id'])
  if @patron.update_attributes(name: params['name'], email: params['email'])
    redirect to("/patrons/#{@patron.id}")
  else
    erb :patron_edit
  end
end

get '/patrons/:id/checkin' do
  @patron = Patron.find_by_id(params['id'])
  @books = Book.where(patron_id: @patron.id)
  erb :patron_checkin
end

post '/patrons/:id/checkin' do
  @patron = Patron.find_by_id(params['id'])
  @book = Book.find_by_id(params['book_id'])
  if @book.update_attributes(patron_id: nil)
    redirect to("/patrons/#{@patron.id}")
  else
    erb :patron_checkin
  end
end

get '/patrons/:id/checkout' do
  @patron = Patron.find_by_id(params['id'])
  @books = Book.where(patron_id: nil)
  erb :patron_checkout
end

post '/patrons/:id/checkout' do
  @patron = Patron.find_by_id(params['id'])
  @book = Book.find_by_id(params['book_id'])

  if @book.update_attributes(patron_id)
    redirect to("/patrons/#{@patron.id}")
  else
    erb :patron_checkout
  end
end
