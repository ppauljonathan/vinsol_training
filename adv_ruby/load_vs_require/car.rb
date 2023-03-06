# frozen_string_literal: true

puts '####car.rb loaded####'

# car class
class Car
  def initialize(make, color)
    @make = make
    @color = color
  end

  def start_engine
    return puts 'Engine already running' if @engine_state

    @engine_state = true
    puts 'Engine idle'
  end
end
