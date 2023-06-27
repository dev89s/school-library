class FileReader
  def read_books
    book_file = File.open('books.json') if File.exist?('books.json')
    return unless book_file

    begin
      books = JSON.parse(book_file.read)
    rescue StandardError
      return
    end
    books_arr = []
    books.each do |book|
      books_arr.append(Book.new(book['title'], book['author']))
    end
    books_arr
  end

  def read_persons
    person_file = File.open('persons.json') if File.exist?('persons.json')
    return unless person_file

    begin
      persons = JSON.parse(person_file.read)
    rescue StandardError
      return
    end
    persons_arr = []
    persons.each do |person|
      if person['type'] == 'Teacher'
        persons_arr.append(Teacher.new(person['age'], person['specialization'], person['name']))
      elsif person['type'] == 'Student'
        persons_arr.append(Student.new(person['age'], person['name'], person['parent_permission']))
      end
    end
    persons_arr
  end
end
