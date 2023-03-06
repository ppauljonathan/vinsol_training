# frozen_string_literal: true

# module for my_attr_accessor
module Accessor
  def define_getter(arg)
    define_method(arg) { instance_variable_get("@#{arg}") }
  end

  def define_setter(arg)
    define_method("#{arg}=") do |val|
      puts "instance variable @#{arg} set to #{val}"
      instance_variable_set("@#{arg}", val)
    end
  end

  def my_attr_accessor(*args)
    args.each do |arg|
      define_getter arg
      define_setter arg
    end
  end
end

# class which uses my_attr_accessor
class A
  extend Accessor
  my_attr_accessor :x

  def initialize
    @x = 10
  end
end

a = A.new
puts a.x
a.x = 30
puts a.x
