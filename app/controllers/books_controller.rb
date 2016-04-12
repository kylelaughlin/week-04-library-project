########################################
####### Books ##########################
########################################

get '/books' do
  @books = Book.all
  erb :"books/index"
end

get '/books/new' do
  @book = Book.new
  @libraries = Library.all
  erb :"books/new"
end

post '/books' do
  @book = Book.new(params)
  @libraries = Library.all
  if @book.save
    redirect to("/books")
  else
    erb :"books/new"
  end
end

get '/books/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(@book.library_id)
  erb :"books/show"
end

get '/books/:id/edit' do
  @book = Book.find_by_id(params['id'])
  @libraries = Library.all
  erb :"books/edit"
end

post '/books/:id' do
  @book = Book.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @book.update_attributes(title: params['title'], author: params['author'],
                              isbn: params['isbn'], library: @library)
    redirect to ("/books/#{@book.id}")
  else
    erb :"books/edit"
  end
end

get '/books/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patrons = Patron.all
  erb :"books/checkout"
end

post '/books/:id/checkout' do
  @book = Book.find_by_id(params['id'])
  @patron = Patron.find_by_id(params['patron_id'])
  if @book.update_attributes(patron: @patron)
    redirect to("/books/#{@book.id}")
  else
    erb :"books/checkout"
  end
end

get '/books/:id/checkin' do
  @book = Book.find_by_id(params['id'])
  if @book.update_attributes(patron_id: nil)
    redirect to("/books/#{@book.id}")
  else
    erb :"books/show"
  end
end
