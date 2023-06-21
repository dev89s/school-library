require './nameable'
require './decorators'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :parent_permission

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age.to_i
    @parent_permission = parent_permission
  end

  private

  def of_age?
    @age > 18
  end

  public

  def can_use_service?
    of_age? || parent_permission
  end

  def correct_name
    @name
  end
end

person = Person.new(28, '   lion sammuael')
puts person.correct_name

capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
