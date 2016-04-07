class Library < ActiveRecord::Base


  has_many :books
  has_many :staff_members

end
