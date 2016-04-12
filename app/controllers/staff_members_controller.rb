########################################
####### Staff Member ###################
########################################

#staff member index
get '/staff_members' do
  @staff_members = StaffMember.all
  erb :"staff_members/index"
end

#staff member new
get '/staff_members/new' do
  @staff_member = StaffMember.new
  @libraries = Library.all
  erb :"staff_members/new"
end

post '/staff_members' do
  @staff_member = StaffMember.new(params)
  @libraries = Library.all
  if @staff_member.save
    redirect to("/staff_members")
  else
    erb :"staff_members/new"
  end
end

# staff member show
get '/staff_members/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library_name = @staff_member.library.branch_name
  erb :"staff_members/show"
end

# staff member edit
get '/staff_members/:id/edit' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @libraries = Library.all
  erb :"staff_members/edit"
end

post '/staff_members/:id' do
  @staff_member = StaffMember.find_by_id(params['id'])
  @library = Library.find_by_id(params['library_id'])
  if @staff_member.update_attributes(name: params['name'],email: params['email'], library: @library)
    redirect to ("/staff_members/#{@staff_member.id}")
  else
    @libraries = Library.all
    erb :"staff_members/edit"
  end
end
