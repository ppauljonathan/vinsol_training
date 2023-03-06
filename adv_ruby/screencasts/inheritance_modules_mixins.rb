# frozen_string_literal: true
# my_ar = Array

# # class Container < Array
# # class Container < my_ar
# class Container < (rand < 0.5 ? Array : Hash)
# end

# # p Container.superclass

# c = Container.new
# c[0] = "hello"
# p c

# # Person = Struct.new(:name, :likes)
# # class Person
# # class Person < Struct.new(:name, :likes)
# Person = Struct.new(:name, :likes) do
#   def to_s
#     "#{name} likes #{likes}"
#   end
# end

# d = Person.new('dave', 'ruby')

# puts d

# class Dave
#   # class << self # do not use if only making class methods
#   #   def say_hello
#   #     puts 'hi'
#   #   end
#   # end
#   @count = 0

#   class << self
#     attr_accessor :count
#   end

#   def self.say_hello
#     puts 'hi'
#   end

#   def initialize
#     self.class.count += 1
#   end
# end

# module Math
#   # ALMOST_PI = 22.0 / 7
#   # class Calculator
#   # end
#   # def self.is_even?(a)
#   #   a & 1 == 0
#   # end
# end

# # puts Math::ALMOST_PI
# # Math::Calculator
# # puts Math.is_even?(12)

# module Logger
#   def log(msg)
#     warn msg
#   end
# end

# class Truck
#   include Logger
# end

# class Ship
#   include Logger
# end
# module instance methods not simply copied into class
# they change heirarchy of class and inheritance

# module Logger
#   def log(msg) # this function is also included in truck class although it is
#     puts "go"  # defined after
#   end
# end

# truck = Truck.new
# truck.log('in truck')

# ship = Ship.new
# ship.log('in ship')

# animal = "cat"

# animal.extend Logger
# # class << animal
# #   include Logger
# # end

# animal.log("miaow")

# class Truck
#   # class << self
#   #   include Logger
#   # end
#   extend Logger
# end

# Truck.log('hi truck')

# module Persistable
#   # hook to check if module is included in a class
#   # automatically extends Persistable::ClassMethods
#   def self.included(cls)
#     cls.extend ClassMethods
#   end

#   module ClassMethods
#     def find
#       puts 'in find'
#       new
#     end
#   end

#   def save
#     puts 'in save'
#   end
# end

# class Person
#   include Persistable
#   # extend Persistable::ClassMethods # instead of this use hooks
# end

# pers = Person.find
# pers.save
