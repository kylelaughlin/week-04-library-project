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
     if books.empty?
       string = "None"
     else
       books.each do |b|
         string += "#{b.title}\n       "
       end
     end
     string
   end
end
