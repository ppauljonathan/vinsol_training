require 'date'

class Person
  def initialize(name, dob)
    @name = name
    @dob = Date.parse(dob)
  end

  def age; end

  def marry(other); end
end

fred = Person.new('Fred', "2002-02-03")
p fred
