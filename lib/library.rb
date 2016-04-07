class Library < ActiveRecord::Base

  validates :branch_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true

  has_many :books
  has_many :staff_members

end
