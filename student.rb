require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission:)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

classroom = Classroom.new('201')

student = Student.new(30, classroom, 'Sasan')
puts student.classroom.label
puts classroom.students.count
puts student.name, student.age, student.play_hooky, student.classroom.label
