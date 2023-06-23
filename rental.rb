class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book

    @person.rentals << self
    @book.rentals << self
  end
end
