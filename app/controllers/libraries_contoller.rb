########################################
####### LIBRARY ########################
########################################

#libraries index
get '/libraries' do
  @libraries = Library.all
  erb :"libraries/index"
end

get '/libraries/new' do
  @library = Library.new
  erb :"libraries/new"
end

post '/libraries' do
  @library = Library.new(params)
  if @library.save
    redirect to("/libraries")
  else
    erb :"libraries/new"
  end
end

#library show
get '/libraries/:id' do
  @library = Library.find_by_id(params['id'])
  @staff_members = StaffMember.where(library_id: params['id'])
  @books = Book.where(library_id: params['id'])
  erb :"libraries/show"
end

#library edit
get '/libraries/:id/edit' do
  @library = Library.find_by_id(params['id'])
  erb :"libraries/edit"
end

post '/libraries/:id' do
  @library = Library.find_by_id(params['id'])
  if @library.update_attributes(branch_name: params['branch_name'],
                                address: params['address'],
                                phone_number: params['phone_number'])
    redirect to ("/libraries/#{@library.id}")
  else
    erb :"libraries/edit"
  end
end

get '/libraries/:id/staff_members' do
  @library = Library.find_by_id(params['id'])
  @staff_members = StaffMember.where(library_id: params['id'])
  erb :"libraries/staff_members"
end
