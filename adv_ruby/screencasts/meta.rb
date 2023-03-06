# frozen_string_literal: true

# class Example
#   # enforces calling order
#   def one
#     puts 'one'
#     def two
#       puts 'two'
#     end
#   end
  
#   def abc
#     def abc
#       @val
#     end
#     puts "expensive calculation"
#     @val = 99
#     # @val ||= 99 # same thing
#   end
# end

# e = Example.new
# # # e.two # does not run
# # e.one
# # e.two # runs

# puts e.abc # runs outer method first
# puts e.abc # runs inner method after outer method has run

# define method

# class Multiplier
#   def self.create_multiplier(n)
#     # define_method(:times_2) do |val|
#     #   val * 2
#     # end
#     define_method("times_#{n}") do |val|
#       val *n
#     end
#   end
#   10.times { |i| create_multiplier(i) }
# end

# m = Multiplier.new
# puts m.times_2(2)
# puts m.times_5(4)

module Accessor
  def my_attr_accessor(var)
    ivar_name = "@#{var}"
    define_method(var) do
      instance_variable_get(ivar_name)
    end

    define_method("#{var}=") do |val|
    warn "{\n  name: @#{var},\n  value: #{val}\n}"
      instance_variable_set(ivar_name, val)
    end
  end
end

class Example
  extend Accessor
  my_attr_accessor :va
end

ex = Example.new
ex.va = 99
ex.va = 2
puts ex.va
