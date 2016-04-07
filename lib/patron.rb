class Patron < ActiveRecord::Base

  validates :name, presence: true
  validates :email, presence: true

   has_many :books

end
