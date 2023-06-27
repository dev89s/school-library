require './app'

def main
  app = App.new

  puts "Welcome to School Library App!\n"
  command = 0
  while command != 7
    show_menu
    command = gets.chomp.to_i
    operate(command, app)
  end
end

def show_menu
  puts 'Please choose an option by entring a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def operate(command, app)
  case command
  when 1..2
    list_op(command, app)
  when 3..5
    create_op(command, app)
  when 6
    app.list_rentals_by_id
  when 7
    app.preserve_data
    exit
  end
end

def list_op(command, app)
  case command
  when 1
    app.list_books
  when 2
    app.list_people
  end
end

def create_op(command, app)
  case command
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  end
end

main
