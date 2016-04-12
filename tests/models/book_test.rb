require_relative "../test_helper"

class BookTest < Minitest::Test

  def test_valid_at_creation
    book = Book.new(title: "Ruby", author: "Andrew", isbn: "1234-5678")
    assert(book.valid?, "Our fixture should be good by default")
  end
end
