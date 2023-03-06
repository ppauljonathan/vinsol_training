# Using Ruby version: ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]
# Your Ruby code here
# frozen_string_literal: false

paul = 'Paul'

# singleton method
def paul.say_hello
  puts 'hello'
end

# defining singleton method inside singleton class
class << paul
  def say_hi
    puts 'hi'
  end
end

puts 'Paul Singleton Methods'
paul.say_hello
paul.say_hi

jonah = 'Jonah'
puts 'Jonah Singleton Methods: '
# throws NoMethodError
jonah.say_hello
jonah.say_hi
