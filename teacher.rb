require './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission:)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end

teacher = Teacher.new(28, 'Computer Science', 'David J. Malon')

puts teacher.name, teacher.age, teacher.can_use_service?
