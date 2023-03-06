# instance_eval do
#   puts self
# end

# "cat".instance_eval { puts upcase }

# class Thing
#   def initialize
#     @var = 123
#   end

#   private
#   def secret
#     puts "ruby"
#   end
# end

# t = Thing.new
# puts t.instance_eval { @var }
# puts t.instance_eval("@var")
# t.instance_eval { secret }

# animal  = 'cat'

# animal.instance_eval do
#   def speak
#     "meow"
#   end
# end

# puts animal.upcase
# puts animal.speak

# class Paul; end
# Paul.instance_eval do
#   def say_hi
#     'hi'
#   end
# end

# puts Paul.say_hi

# String.class_eval do
#   puts self
# end

# String.class_eval do
#   def with_cat
#     "kitty says: #{self}"
#   end
# end

# puts "meow".with_cat

# module Accessor
#   def my_attr_accessor(name)
#     class_eval %{
#       def #{name}
#         @#{name}
#       end

#       def #{name}=(val)
#         @#{name} = val
#       end
#     }
#   end
# end

# class MyClass
#   extend Accessor
#   my_attr_accessor :var
# end

# n = MyClass.new

# n.var = 10
# puts n.var

# class A
#   @@a = 10
#   puts @@a
#   B = Class.new do
#     puts @@a
#     @@a += 2
#     C = Class.new do
#       puts @@a
#     end
#   end
# end
