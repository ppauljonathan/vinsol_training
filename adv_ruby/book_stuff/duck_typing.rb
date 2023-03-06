# frozen_string_literal: true

class Whale
  def swim
    puts 'whale swim'
  end
end

class Duck
  def quack
    puts 'Duck quack'
  end

  def swim
    puts 'Duck swim'
  end
end

class Goose
  def quack
    puts 'Goose quack'
  end

  def swim
    puts 'Goose swim'
  end
end

class BirdActions
  attr_reader :birds

  def initialize
    @birds = []
    @birds.push(Duck.new, Goose.new, Whale.new)
  end

  def quack
    birds.each(&:quack)
  end

  def swim
    birds.each(&:swim)
  end
end
action = BirdActions.new
action.swim
action.quack
