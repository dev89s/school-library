require './student'
require './teacher'
require './book'
require './rental'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def begin
    puts 'Welcome to School Library App!'
    puts "\n"

    while true
      puts 'Please choose an option by entring a number:'
      puts '1 - List all books'
      puts '2 - List all people'
      puts '3 - Create a person'
      puts '4 - Create a book'
      puts '5 - Create a rental'
      puts '6 - List all rentals for a given person id'
      puts '7 - Exit'
      command = gets.chomp
      list_books if command == '1'
      list_people if command == '2'
      create_person if command == '3'
      create_book if command == '4'
      create_rental if command == '5'
      list_rentals_by_id if command == '6'
      break if command == '7'
    end
  end

  def list_books
    puts 'no books' unless @books.length.positive?
    @books.each do |book|
      print "Title: #{book.title}, Author: #{book.author}\n"
    end
    puts "\n"
  end

  def list_people
    puts 'no people' unless @persons.length.positive?
    'No people' unless @persons.length.positive?
    @persons.each do |person|
      if person.instance_of?(Teacher)
        print '[Teacher] '
      elsif person.instance_of?(Student)
        print '[Student] '
      end
      print "Name: #{person.name}, "
      print "ID: #{person.id}, "
      print "Age: #{person.age}\n"
    end
    puts "\n"
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    peprson_type = gets.chomp
    if peprson_type == '1'
      create_student
    elsif peprson_type == '2'
      create_teacher
    end
  end

  def create_student
    print 'Age: '
    age = gets.chomp.strip.to_i
    print 'Name: '
    name = gets.chomp.strip.split.map(&:capitalize).join(' ')
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    perm = %w[y Y].include?(permission)
    student = Student.new(age, nil, name, parent_permission: perm)
    @persons.append(student)
    print "Person created successfully\n\n"
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.strip.to_i
    print 'Name: '
    name = gets.chomp.strip.split.map(&:capitalize).join(' ')
    print 'Specialization: '
    specialization = gets.chomp.strip.split.map(&:capitalize).join(' ')
    teacher = Teacher.new(age, specialization, name)
    @persons.append(teacher)
    print "Person created successfully\n\n"
  end

  def create_book
    print 'Title: '
    title = gets.chomp.strip.split.map(&:capitalize).join(' ')
    print 'Author: '
    author = gets.chomp.strip.split.map(&:capitalize).join(' ')
    book = Book.new(title, author)
    @books.append(book)
    print "Book created successfully\n\n"
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_num = gets.chomp.to_i

    puts 'Select a person from the following list by number (not id):'
    @persons.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_num = gets.chomp.to_i

    print 'Date: '
    date = gets.chomp.strip

    rental = Rental.new(date, @persons[person_num], @books[book_num])

    @rentals.append(rental)
    puts 'Rental created successfully'
  end

  def list_rentals_by_id
    puts 'ID of person:'
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}" if rental.person.id == id
    end
  end
end

def main
  app = App.new
  app.begin
end

main
