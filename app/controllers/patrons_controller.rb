########################################
####### Patron #########################
########################################

get '/patrons' do
  @patrons = Patron.all
  erb :"patrons/index"
end

get '/patrons/new' do
  @patron = Patron.new
  erb :"patrons/new"
end

post '/patrons' do
  @patron = Patron.new(params)
  if @patron.save
    redirect to("/patrons")
  else
    erb :"patrons/new"
  end
end

get '/patrons/:id' do
  @patron = Patron.find_by_id(params['id'])
  erb :"patrons/show"
end

get '/patrons/:id/edit' do
  @patron = Patron.find_by_id(params['id'])
  erb :"patrons/edit"
end

post '/patrons/:id' do
  @patron = Patron.find_by_id(params['id'])
  if @patron.update_attributes(name: params['name'], email: params['email'])
    redirect to("/patrons/#{@patron.id}")
  else
    erb :"patrons/edit"
  end
end

get '/patrons/:id/checkin' do
  @patron = Patron.find_by_id(params['id'])
  @books = Book.where(patron_id: @patron.id)
  erb :"patrons/checkin"
end

post '/patrons/:id/checkin' do
  @patron = Patron.find_by_id(params['id'])
  @book = Book.find_by_id(params['book_id'])
  if @book.update_attributes(patron_id: nil)
    redirect to("/patrons/#{@patron.id}")
  else
    erb :"patrons/checkin"
  end
end

get '/patrons/:id/checkout' do
  @patron = Patron.find_by_id(params['id'])
  @books = Book.where(patron_id: nil)
  erb :"patrons/checkout"
end

post '/patrons/:id/checkout' do
  @patron = Patron.find_by_id(params['id'])
  @book = Book.find_by_id(params['book_id'])

  if @book.update_attributes(patron_id)
    redirect to("/patrons/#{@patron.id}")
  else
    erb :"patrons/checkout"
  end
end
