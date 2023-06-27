require './student'
require './teacher'
require './book'
require './rental'
require 'json'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def read_date_from_files
    read_persons
    read_books
    read_rentals
  end

  def read_books
    book_file = File.open('books.json') if File.exist?('books.json')
    return unless book_file

    begin
      books = JSON.parse(book_file.read)
    rescue StandardError
      return
    end
    books.each do |book|
      @books.append(Book.new(book['title'], book['author']))
    end
  end

  def read_persons
    person_file = File.open('persons.json') if File.exist?('persons.json')
    return unless person_file

    begin
      persons = JSON.parse(person_file.read)
    rescue StandardError
      return
    end

    persons.each do |person|
      if person['type'] == 'Teacher'
        @persons.append(Teacher.new(person['age'], person['specialization'], person['name']))
      elsif person['type'] == 'Student'
        @persons.append(Student.new(person['age'], person['name'], person['parent_permission']))
      end
    end
  end

  def read_rentals
    rental_file = File.open('rentals.json') if File.exist?('rentals.json')
    return unless rental_file

    begin
      rentals = JSON.parse(rental_file.read)
    rescue StandardError
      return
    end

    rentals.each do |rental|
      person = @persons.find { |p| p.name == rental['person_name'] }
      book = @books.find { |b| b.title == rental['book_title'] }
      @rentals.append(Rental.new(rental['date'], person, book))
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

  def preserve_data
    preserve_books if @books.length.positive?
    preserve_persons if @persons.length.positive?
    preserve_rentals if @rentals.length.positive?
  end

  def preserve_books
    books = @books.map { |book| { title: book.title, author: book.author } }
    file = File.open('books.json', 'w')
    file.write(books.to_json)
  end

  def preserve_persons
    persons = @persons.map do |person|
      if person.instance_of?(Teacher)
        { type: 'Teacher', name: person.name, age: person.age, specialization: person.specialization }
      elsif person.instance_of?(Student)
        { type: 'Student', name: person.name, age: person.age, parent_permission: person.parent_permission }
      end
    end
    file = File.open('persons.json', 'w')
    file.write(persons.to_json)
  end

  def preserve_rentals
    rentals = @rentals.map do |rental|
      { date: rental.date, person_name: rental.person.name, book_title: rental.book.title }
    end
    file = File.open('rentals.json', 'w')
    file.write(rentals.to_json)
  end
end
