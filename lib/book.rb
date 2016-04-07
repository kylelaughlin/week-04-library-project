class Book < ActiveRecord::Base

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true
  

  belongs_to :library
  belongs_to :patron

end
