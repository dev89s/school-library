class Rental
  attr_reader :person, :book
  attr_accessor :date

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book

    @person.rentals.append(self)
    @book.rentals.append(self)
  end
end
