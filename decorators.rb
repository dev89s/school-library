require './nameable'

class NameDecorator < Nameable
  attr_accessor :nameable

  def initialize(nameable)
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < NameDecorator
  def correct_name
    @nameable.correct_name.split(/ /).map(&:capitalize).join(' ')
  end
end

class TrimmerDecorator < NameDecorator
  def correct_name
    output = @nameable.correct_name.strip
    if output.length > 10
      output[0..9]
    else
      output
    end
  end
end
