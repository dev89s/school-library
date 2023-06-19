require './person'

class Student < Person
  def initialize(age, classrooom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission:)
    @classrooom = classrooom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

student = Student.new(30, 201, 'Sasan')

puts student.name, student.age, student.play_hooky
