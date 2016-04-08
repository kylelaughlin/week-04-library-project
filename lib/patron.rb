class Patron < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

   has_many :books

   # Creates a string which displays all books checked out by a patron
   #
   # Returns the created string
   def books_display
     books = Book.where(patron_id: id)
     string = ""
     books.each do |b|
       string += "#{b.title}\n       "
     end
     string
   end
end
